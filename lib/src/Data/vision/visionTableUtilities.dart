import 'package:testapp/src/models.dart';

import '../contactsDatabase.dart';

class VisionTableUtilities {
  static Future<List<Vision>> getContacts() async {
    var db = await ContactsDatabase.get().getDb();
    var result = await db.rawQuery('SELECT * FROM Vision');
    if (result.length == 0) return new List<Vision>();
    return result.map((c) => Vision.fromMap(c)).toList();
  }

  static Future<Vision> getVision(String id) async {
    var db = await ContactsDatabase.get().getDb();
    var result =
        await db.rawQuery('SELECT * FROM Vision WHERE ${Vision.dbId} = "$id"');
    if (result.length == 0) return null;
    return new Vision.fromMap(result[0]);
  }

  static Future<Vision> getVisionByContact(String contactId) async {
    var db = await ContactsDatabase.get().getDb();
    var result = await db.rawQuery(
        'SELECT * FROM Vision WHERE ${Vision.dbContactId} = "$contactId"');
    if (result.length == 0) return null;
    return new Vision.fromMap(result[0]);
  }

  static Future<int> updateVision(Vision vision) async {
    var db = await ContactsDatabase.get().getDb();
    return db.rawInsert('INSERT OR REPLACE INTO '
        'Vision(${Vision.dbId}, ${Vision.dbContactId}, ${Vision.dbNames}, ${Vision.dbEmails}, ${Vision.dbPhones}, ${Vision.dbWebsites}, ${Vision.dbAddresses}, ${Vision.dbAltAddresses}, ${Vision.dbCszAddresses})'
        ' VALUES("${vision.id}", "${vision.contactId}", "${Vision.stringify(vision.names)}", "${Vision.stringify(vision.emails)}", "${Vision.stringify(vision.phones)}", "${Vision.stringify(vision.websites)}", "${Vision.stringify(vision.addresses)}", "${Vision.stringify(vision.altAddresses)}", "${Vision.stringify(vision.cszAddresses)}")');
  }
}
