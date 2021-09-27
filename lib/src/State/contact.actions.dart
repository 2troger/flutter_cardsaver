import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:testapp/src/models.dart';

enum ContactActions {
  GetContacts,
  GetContactsSucceeded,
  AddContact,
  AddContactSucceeded,
  UpdateContact,
  SaveUpdatedContact,
  SaveUpdatedContactSucceeded,
  SelectContact,
  SelectVision,
  ProcessVision
}

abstract class ReduxAction {
  get type;
}

class GetContacts implements ReduxAction {
  get type => ContactActions.GetContacts;
}

class GetContactsSucceeded implements ReduxAction {
  get type => ContactActions.GetContactsSucceeded;
  List<Contact> contacts;
  GetContactsSucceeded({@required this.contacts});
}

class AddContact implements ReduxAction {
  get type => ContactActions.AddContact;
  String imagePath;
  Uint8List image;
  AddContact({this.imagePath, this.image});
}

class AddContactSucceeded implements ReduxAction {
  get type => ContactActions.AddContactSucceeded;
  Contact contact;
  AddContactSucceeded({@required this.contact});
}

// used to change fields from inputs on stored contact
class UpdateContact implements ReduxAction {
  get type => ContactActions.UpdateContact;
  String propertyName;
  String propertyValue;
  UpdateContact({@required this.propertyName, @required this.propertyValue});
}

class SaveUpdatedContact implements ReduxAction {
  get type => ContactActions.SaveUpdatedContact;
}

class SaveUpdatedContactSucceeded implements ReduxAction {
  get type => ContactActions.SaveUpdatedContactSucceeded;
}

class SelectContact implements ReduxAction {
  get type => ContactActions.SelectContact;
  Contact contact;
  SelectContact({@required this.contact});
}

class SelectVision implements ReduxAction {
  get type => ContactActions.SelectVision;
  Vision vision;
  SelectVision({@required this.vision});
}

class ProcessVision implements ReduxAction {
  get type => ContactActions.ProcessVision;
  Vision vision;
  ProcessVision({@required this.vision});
}
