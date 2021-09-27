import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:testapp/src/State/contact.actions.dart';
import 'package:testapp/src/State/contact.reducers.dart';
import 'package:testapp/src/models.dart';
import './ContactInformationRowWidget/contactInformationRowWidget.dart';

class ContactDetailWidget extends StatelessWidget {
  ContactDetailWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contact =
        StoreProvider.of<ContactState>(context).state.selectedContact;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16, left: 12, right: 12),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      height: 200,
                      child: Hero(
                        tag: 'contact-hero-${contact.id}',
                        child: Image.memory(
                          contact.image,
                        ),
                      ),
                    ),
                    StoreConnector<ContactState, PropertyRow>(
                      distinct: true,
                      converter: (store) => PropertyRow(
                          propertyValue: store.state.selectedContact?.name,
                          visionValues:
                              store.state.selectedVision?.names ?? <String>[]),
                      builder: (context, row) {
                        return ContactInformationRowWidget(
                          labelText: "Name",
                          valueText: row.propertyValue,
                          updateText: (newVal) {
                            updateContact(context, "name", newVal);
                          },
                          suggestions: row.visionValues,
                        );
                      },
                    ),
                    StoreConnector<ContactState, PropertyRow>(
                      distinct: true,
                      converter: (store) => PropertyRow(
                          propertyValue: store.state.selectedContact?.title,
                          visionValues:
                              store.state.selectedVision?.names ?? <String>[]),
                      builder: (context, row) {
                        return ContactInformationRowWidget(
                          labelText: "Title",
                          valueText: row.propertyValue,
                          updateText: (newVal) {
                            updateContact(context, "title", newVal);
                          },
                          suggestions: row.visionValues,
                        );
                      },
                    ),
                    StoreConnector<ContactState, PropertyRow>(
                      distinct: true,
                      converter: (store) => PropertyRow(
                          propertyValue: store.state.selectedContact?.company,
                          visionValues:
                              store.state.selectedVision?.names ?? <String>[]),
                      builder: (context, row) {
                        return ContactInformationRowWidget(
                          labelText: "Company",
                          valueText: row.propertyValue,
                          updateText: (newVal) {
                            updateContact(context, "company", newVal);
                          },
                          suggestions: row.visionValues,
                        );
                      },
                    ),
                    StoreConnector<ContactState, PropertyRow>(
                      distinct: true,
                      converter: (store) => PropertyRow(
                          propertyValue: store.state.selectedContact?.email,
                          visionValues:
                              store.state.selectedVision?.emails ?? <String>[]),
                      builder: (context, row) {
                        return ContactInformationRowWidget(
                          labelText: "Email",
                          valueText: row.propertyValue,
                          updateText: (newVal) {
                            updateContact(context, "email", newVal);
                          },
                          suggestions: row.visionValues,
                          inputType: TextInputType.emailAddress,
                        );
                      },
                    ),
                    StoreConnector<ContactState, PropertyRow>(
                      distinct: true,
                      converter: (store) => PropertyRow(
                          propertyValue: store.state.selectedContact?.phone,
                          visionValues:
                              store.state.selectedVision?.phones ?? <String>[]),
                      builder: (context, row) {
                        return ContactInformationRowWidget(
                          labelText: "Phone",
                          valueText: row.propertyValue,
                          updateText: (newVal) {
                            updateContact(context, "phone", newVal);
                          },
                          suggestions: row.visionValues,
                          inputType: TextInputType.phone,
                        );
                      },
                    ),
                    StoreConnector<ContactState, PropertyRow>(
                      distinct: true,
                      converter: (store) => PropertyRow(
                          propertyValue: store.state.selectedContact?.website,
                          visionValues: store.state.selectedVision?.websites ??
                              <String>[]),
                      builder: (context, row) {
                        return ContactInformationRowWidget(
                          labelText: "Website",
                          valueText: row.propertyValue,
                          updateText: (newVal) {
                            updateContact(context, "website", newVal);
                          },
                          suggestions: row.visionValues,
                          inputType: TextInputType.url,
                        );
                      },
                    ),
                    StoreConnector<ContactState, PropertyRow>(
                      distinct: true,
                      converter: (store) => PropertyRow(
                          propertyValue: store.state.selectedContact?.address,
                          visionValues: store.state.selectedVision?.addresses ??
                              <String>[]),
                      builder: (context, row) {
                        return ContactInformationRowWidget(
                          labelText: "Address",
                          valueText: row.propertyValue,
                          updateText: (newVal) {
                            updateContact(context, "address", newVal);
                          },
                          suggestions: row.visionValues,
                        );
                      },
                    ),
                    StoreConnector<ContactState, PropertyRow>(
                      distinct: true,
                      converter: (store) => PropertyRow(
                          propertyValue:
                              store.state.selectedContact?.altAddress,
                          visionValues:
                              store.state.selectedVision?.altAddresses ??
                                  <String>[]),
                      builder: (context, row) {
                        return ContactInformationRowWidget(
                          labelText: "Alt Address",
                          valueText: row.propertyValue,
                          updateText: (newVal) {
                            updateContact(context, "altAddress", newVal);
                          },
                          suggestions: row.visionValues,
                        );
                      },
                    ),
                    StoreConnector<ContactState, PropertyRow>(
                      distinct: true,
                      converter: (store) => PropertyRow(
                          propertyValue:
                              store.state.selectedContact?.cszAddress,
                          visionValues:
                              store.state.selectedVision?.cszAddresses ??
                                  <String>[]),
                      builder: (context, row) {
                        return ContactInformationRowWidget(
                          labelText: "City, State Zip",
                          valueText: row.propertyValue,
                          updateText: (newVal) {
                            updateContact(context, "cszAddress", newVal);
                          },
                          suggestions: row.visionValues,
                        );
                      },
                    ),
                    StoreConnector<ContactState, String>(
                      distinct: true,
                      converter: (store) => store.state.selectedContact?.note,
                      builder: (context, note) {
                        return TextField(
                          controller: TextEditingController(text: note),
                          onChanged: (newVal) {
                            updateContact(context, "note", newVal);
                          },
                          maxLines: 8,
                          textInputAction: TextInputAction.newline,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(labelText: "Notes"),
                          keyboardType: TextInputType.multiline,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Save & Close"),
                onPressed: () {
                  StoreProvider.of<ContactState>(context)
                      .dispatch(SaveUpdatedContact());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateContact(BuildContext context, String property, dynamic value) {
    StoreProvider.of<ContactState>(context).dispatch(UpdateContact(
      propertyName: property,
      propertyValue: value,
    ));
  }
}
