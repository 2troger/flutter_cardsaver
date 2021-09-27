import 'package:meta/meta.dart';
import 'package:testapp/src/models.dart';
import './contact.actions.dart';

@immutable
class ContactState {
  final List<Contact> contacts;
  final Contact selectedContact;
  final Vision selectedVision;

  ContactState({
    @required this.contacts,
    @required this.selectedContact,
    this.selectedVision,
  });

  factory ContactState.initial() {
    return ContactState(
      contacts: List<Contact>(),
      selectedContact: null,
      selectedVision: null,
    );
  }

  ContactState copyWith({
    List<Contact> contacts,
    Contact selectedContact,
    Vision selectedVision,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      selectedContact: selectedContact ?? this.selectedContact,
      selectedVision: selectedVision ?? this.selectedVision,
    );
  }
}

ContactState contactReducer(ContactState state, action) {
  switch (action.type) {
    case ContactActions.GetContactsSucceeded:
      {
        return state.copyWith(
          contacts: action.contacts,
        );
      }

    case ContactActions.AddContactSucceeded:
    case ContactActions.SelectContact:
      {
        return state.copyWith(
          selectedContact: action.contact,
        );
      }

    case ContactActions.ProcessVision:
    case ContactActions.SelectVision:
      {
        return state.copyWith(
          selectedVision: action.vision,
        );
      }

    case ContactActions.SaveUpdatedContactSucceeded:
      {
        return state.copyWith(
          selectedContact: null,
          selectedVision: null,
        );
      }

    case ContactActions.UpdateContact:
      {
        final contactMap = state.selectedContact.toMap();
        contactMap[action.propertyName] = action.propertyValue;
        return state.copyWith(
          selectedContact: Contact.fromMap(contactMap),
        );
      }

    default:
      {
        return state;
      }
  }
}
