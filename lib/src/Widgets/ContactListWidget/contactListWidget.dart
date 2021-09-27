import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:testapp/src/State/contact.actions.dart';
import 'package:testapp/src/State/contact.reducers.dart';
import 'package:testapp/src/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'ContactCellWidget/contactCellWidget.dart';

class ContactListWidget extends StatelessWidget {
  ContactListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: StoreConnector<ContactState, List<Contact>>(
          distinct: true,
          onInit: (store) {
            store.dispatch(GetContacts());
          },
          converter: (store) {
            return store.state.contacts;
          },
          builder: (context, contacts) {
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemExtent: 130.0,
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return ContactCellWidget(
                  contact: contacts[index],
                  selectContact: () {
                    StoreProvider.of<ContactState>(context)
                        .dispatch(SelectContact(contact: contacts[index]));
                  },
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (kIsWeb) {
            final image = await startWebFilePicker();
            if (image.isNotEmpty) {
              StoreProvider.of<ContactState>(context)
                  .dispatch(AddContact(image: image));
            }
          } else {
            final imagePath = await getPicture(context);
            if (imagePath != null) {
              StoreProvider.of<ContactState>(context)
                  .dispatch(AddContact(imagePath: imagePath));
            }
          }
        },
        tooltip: 'Add Contact',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<String> getPicture(context) async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Choose picture source:"),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Camera"),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
            SimpleDialogOption(
              child: Text("Gallery"),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );
    if (source != null) {
      try {
        var imageFile = await ImagePicker.pickImage(
            source: source, maxWidth: 1200, maxHeight: 1200);
        if (imageFile != null) {
          var type = imageFile.path.substring(imageFile.path.lastIndexOf('.'));

          final directory = await getApplicationDocumentsDirectory();
          final newImage = await imageFile.copy(
              '${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}$type');
          return newImage.path;
        }
      } catch (PlatformException, e) {
        log(e.toString());
        // Camera or Gallery not available
      }
    }
    return null;
  }

  Future<Uint8List> startWebFilePicker() async {
    // InputElement uploadInput = FileUploadInputElement();
    // uploadInput.click();

    // await for (var event in uploadInput.onChange) {
    //   final files = (event.target as InputElement).files;
    //   if (files.length == 1) {
    //     final file = files[0];
    //     FileReader reader = FileReader();
    //     reader.readAsArrayBuffer(file);

    //     await for (var loadEndEvent in reader.onLoadEnd) {
    //       return reader.result;
    //     }
    //   }
    // }
  }
}
