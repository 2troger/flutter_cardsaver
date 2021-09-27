import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quiver/strings.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:testapp/src/Nav/navKey.dart';
import 'package:testapp/src/State/contact.actions.dart';
import 'package:testapp/src/State/contact.reducers.dart';
import 'package:testapp/src/State/contact.utilities.dart';
import 'package:testapp/src/data.dart';
import 'package:testapp/src/models.dart';
import 'package:uuid/uuid.dart';

Stream<dynamic> getContactsEpic(
    Stream<dynamic> actions, EpicStore<ContactState> store) {
  return actions
      .where((action) =>
          action is GetContacts ||
          action is AddContactSucceeded ||
          action is SaveUpdatedContactSucceeded)
      .asyncMap((action) async {
    final contacts = await ContactTableUtilities.getContacts();
    contacts.sort((a, b) => b.createdOn.compareTo(a.createdOn));
    return GetContactsSucceeded(contacts: contacts);
  });
}

Stream<dynamic> addContactEpic(
    Stream<dynamic> actions, EpicStore<ContactState> store) {
  return actions
      .where((action) => action is AddContact)
      .asyncMap((action) async {
    final uuid = Uuid().v4();
    var image = action.image;
    var imagePath = action.imagePath;
    if (isNotBlank(action.imagePath) && isBlank(action.image)) {
      image = await File(action.imagePath).readAsBytes();
      imagePath =
          action.imagePath.substring(action.imagePath.lastIndexOf('/') + 1);
    }
    final contact = Contact(
        id: uuid,
        name: "",
        createdOn: DateTime.now(),
        completed: false,
        image: image,
        imagePath: imagePath);
    await ContactTableUtilities.updateContact(contact);
    return AddContactSucceeded(contact: Contact.copy(contact));
  });
}

Stream<dynamic> updateContactEpic(
    Stream<dynamic> actions, EpicStore<ContactState> store) {
  return actions
      .where((action) => action is SaveUpdatedContact)
      .asyncMap((action) async {
    final contact = store.state.selectedContact;
    contact.completed = true;
    await ContactTableUtilities.updateContact(contact);
    NavKey.navKey.currentState.pop();
    return SaveUpdatedContactSucceeded();
  });
}

Stream<dynamic> selectContactEpic(
    Stream<dynamic> actions, EpicStore<ContactState> store) {
  return actions
      .where(
          (action) => action is SelectContact || action is AddContactSucceeded)
      .asyncMap((action) async {
    NavKey.navKey.currentState.pushNamed('/detail');
    var vis = await VisionTableUtilities.getVisionByContact(action.contact.id);
    if (vis == null) {
      vis = Vision(
        id: Uuid().v4(),
        contactId: action.contact.id,
        names: <String>[],
        emails: <String>[],
        phones: <String>[],
        websites: <String>[],
        addresses: <String>[],
        altAddresses: <String>[],
        cszAddresses: <String>[],
      );
      await VisionTableUtilities.updateVision(vis);
    }
    return ProcessVision(vision: vis);
  });
}

Stream<dynamic> processVisionEpic(
    Stream<dynamic> actions, EpicStore<ContactState> store) {
  return actions
      .where((action) => action is ProcessVision)
      .asyncMap((action) async {
    final directory = await getApplicationDocumentsDirectory();
    if (isNotBlank(store.state.selectedContact.imagePath)) {
      final imagePath =
          "${directory.path}/${store.state.selectedContact.imagePath}";
      var imageFile = File(imagePath);
      if (!await imageFile.exists()) {
        imageFile = await imageFile.create();
      }
      await imageFile.writeAsBytes(store.state.selectedContact.image);
      final FirebaseVisionImage visionImage =
          FirebaseVisionImage.fromFile(imageFile);
      var vals = List<String>();
      try {
        final TextRecognizer textRecognizer =
            FirebaseVision.instance.textRecognizer();
        final visionText = await textRecognizer.processImage(visionImage);
        textRecognizer.close();

        vals = visionText.text.split("\n");
      } catch (PlatformException) {}
      final vision = processValues(store.state.selectedVision, vals);
      await VisionTableUtilities.updateVision(vision);
      return SelectVision(vision: vision);
    }
    return Stream.empty();
  });
}
