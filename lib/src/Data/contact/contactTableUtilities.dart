import 'dart:convert';
import 'package:testapp/src/models.dart';

import '../contactsDatabase.dart';

class ContactTableUtilities {
  static Future<List<Contact>> getContacts() async {
    var db = await ContactsDatabase.get().getDb();
    var result = await db.rawQuery('SELECT * FROM Contact');
    if (result.length == 0) return new List<Contact>();
    return result.map((c) => Contact.fromDbMap(c)).toList();
  }

  static Future<Contact> getContact(String id) async {
    var db = await ContactsDatabase.get().getDb();
    var result = await db
        .rawQuery('SELECT * FROM Contact WHERE ${Contact.dbId} = "$id"');
    if (result.length == 0) return null;
    return new Contact.fromDbMap(result[0]);
  }

  static Future<int> updateContact(Contact contact) async {
    var db = await ContactsDatabase.get().getDb();
    return db.rawInsert('INSERT OR REPLACE INTO '
        'Contact(${Contact.dbId}, ${Contact.dbName}, ${Contact.dbCreatedOn}, ${Contact.dbCompleted}, ${Contact.dbImage}, ${Contact.dbImagePath}, ${Contact.dbTitle}, ${Contact.dbCompany}, ${Contact.dbEmail}, ${Contact.dbPhone}, ${Contact.dbWebsite}, ${Contact.dbAddress}, ${Contact.dbAltAddress}, ${Contact.dbCszAddress}, ${Contact.dbNote})'
        ' VALUES("${contact.id}", "${contact.name}", "${contact.createdOn}", ${contact.completed ? 1 : 0}, "${Base64Encoder().convert(contact.image)}", "${contact.imagePath}", "${contact.title}", "${contact.company}", "${contact.email}", "${contact.phone}", "${contact.website}", "${contact.address}", "${contact.altAddress}", "${contact.cszAddress}", "${contact.note}")');
  }
}
