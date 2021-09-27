import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testapp/src/models.dart';

class ContactCellWidget extends StatelessWidget {
  ContactCellWidget({Key key, this.contact, this.selectContact})
      : super(key: key);

  final Contact contact;
  final selectContact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (tap) => selectContact(),
      behavior: HitTestBehavior.translucent,
      child: Container(
        color: contact.completed ? Color(0xFFFFFFFF) : Color(0xFFFFE5E5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              width: 180,
              child: Hero(
                tag: 'contact-hero-${contact.id}',
                child: new Image.memory(
                  contact.image,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    contact.name.isNotEmpty
                        ? Text(
                            contact.name,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Container(),
                    Text(
                      new DateFormat.yMMMd().format(contact.createdOn),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
