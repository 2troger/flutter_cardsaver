import 'package:meta/meta.dart';

class Vision {
  static get dbId => "id";
  static get dbContactId => "contactId";
  static get dbNames => "names";
  static get dbEmails => "emails";
  static get dbPhones => "phones";
  static get dbWebsites => "websites";
  static get dbAddresses => "addresses";
  static get dbAltAddresses => "altAddresses";
  static get dbCszAddresses => "cszAddresses";

  static get regexName => "[A-Za-z-., &]{2,}\\s*[A-Za-z-.,&]{2,}";
  static get regexEmail => "((.[^ ])+)\\@((.[^ ])+)[.]([A-Za-z]{2,4})";
  static get regexPhone =>
      "((\\(\\d{3}\\) ?)|(\\d{3}-)|(\\d{3}.))?(\\d{3}-\\d{4}|\\d{3}.\\d{4})";
  static get regexAddress =>
      "(\\d+)\\s([A-Za-z .]+\\n?)"; // number and street - might have some of pt2
  static get regexAltAddress => "\\w*[A-Za-z]{2,}\\s\\d+"; //Secondary optional
  static get regexCszAddress =>
      "[A-Za-z]+\\,\\s[A-Za-z]+\\s\\d*"; //City-state-zip
  static get regexWebsite =>
      "(http\\:\\/\\/|https\\:\\/\\/)?([w]{3}\\.)?[a-z1-9]+\\.+[A-Za-z]{2,4}[^ ]*";

  String id, contactId;
  List<String> names;
  List<String> emails;
  List<String> phones;
  List<String> websites;
  List<String> addresses;
  List<String> altAddresses;
  List<String> cszAddresses;

  Vision({
    @required this.id,
    @required this.contactId,
    this.names = const [],
    this.emails = const [],
    this.phones = const [],
    this.websites = const [],
    this.addresses = const [],
    this.altAddresses = const [],
    this.cszAddresses = const [],
  });

  Vision.fromMap(Map<String, dynamic> map)
      : this(
          id: map[dbId],
          contactId: map[dbContactId],
          names: Vision.toList(map[dbNames], ";"),
          emails: Vision.toList(map[dbEmails], ";"),
          phones: Vision.toList(map[dbPhones], ";"),
          websites: Vision.toList(map[dbWebsites], ";"),
          addresses: Vision.toList(map[dbAddresses], ";"),
          altAddresses: Vision.toList(map[dbAltAddresses], ";"),
          cszAddresses: Vision.toList(map[dbCszAddresses], ";"),
        );

  static String stringify(List<String> list) {
    if (list.length == 0) {
      return "";
    }
    return list.reduce((total, item) => "$total;$item");
  }

  static List<String> toList(String deliminated, String pattern) {
    if (deliminated.isEmpty) {
      return <String>[];
    }
    return deliminated.split(pattern);
  }
}
