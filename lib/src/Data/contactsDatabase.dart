import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:testapp/src/models.dart';

class ContactsDatabase {
  static final ContactsDatabase _contactDatabase =
      new ContactsDatabase._internal();

  bool didInit = false;

  Database db;

  static ContactsDatabase get() {
    return _contactDatabase;
  }

  Future<Database> getDb() async {
    if (!didInit) await init();
    return db;
  }

  ContactsDatabase._internal();

  Future init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "contact.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Contact ("
          "${Contact.dbId} STRING PRIMARY KEY,"
          "${Contact.dbName} TEXT,"
          "${Contact.dbCreatedOn} DATETIME,"
          "${Contact.dbCompleted} BIT,"
          "${Contact.dbImage} TEXT,"
          "${Contact.dbImagePath} TEXT,"
          "${Contact.dbTitle} TEXT,"
          "${Contact.dbCompany} TEXT,"
          "${Contact.dbEmail} TEXT,"
          "${Contact.dbPhone} TEXT,"
          "${Contact.dbWebsite} TEXT,"
          "${Contact.dbAddress} TEXT,"
          "${Contact.dbAltAddress} TEXT,"
          "${Contact.dbCszAddress} TEXT,"
          "${Contact.dbNote} TEXT"
          ")");

      await db.execute("CREATE TABLE Vision ("
          "${Vision.dbId} STRING PRIMARY KEY,"
          "${Vision.dbContactId} TEXT REFERENCES contact,"
          "${Vision.dbNames} TEXT,"
          "${Vision.dbEmails} TEXT,"
          "${Vision.dbPhones} TEXT,"
          "${Vision.dbWebsites} TEXT,"
          "${Vision.dbAddresses} TEXT,"
          "${Vision.dbAltAddresses} TEXT,"
          "${Vision.dbCszAddresses} TEXT"
          ")");
    });
    didInit = true;
  }
}
