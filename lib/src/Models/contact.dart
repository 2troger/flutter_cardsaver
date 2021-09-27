import 'package:meta/meta.dart';
import 'dart:convert';

class Contact {
  static final dbId = "id";
  static final dbCreatedOn = "createdOn";
  static final dbCompleted = "completed";
  static final dbImage = "image";
  static final dbImagePath = "imagePath";
  static final dbName = "name";
  static final dbTitle = "title";
  static final dbCompany = "company";
  static final dbEmail = "email";
  static final dbPhone = "phone";
  static final dbWebsite = "website";
  static final dbAddress = "address";
  static final dbAltAddress = "altAddress";
  static final dbCszAddress = "cszAddress";
  static final dbNote = "note";

  String id,
      imagePath,
      name,
      title,
      company,
      email,
      phone,
      website,
      address,
      altAddress,
      cszAddress,
      note;
  bool completed;
  DateTime createdOn;
  List<int> image;

  Contact({
    @required this.id,
    @required this.createdOn,
    @required this.completed,
    @required this.image,
    @required this.imagePath,
    this.name = "",
    this.title = "",
    this.company = "",
    this.email = "",
    this.phone = "",
    this.website = "",
    this.address = "",
    this.altAddress = "",
    this.cszAddress = "",
    this.note = "",
  });

  Map<String, dynamic> toMap() {
    final mapped = Map<String, dynamic>();
    mapped.addAll({
      "id": this.id,
      "name": this.name,
      "createdOn": this.createdOn,
      "completed": this.completed,
      "image": this.image,
      "imagePath": this.imagePath,
      "title": this.title,
      "company": this.company,
      "email": this.email,
      "phone": this.phone,
      "website": this.website,
      "address": this.address,
      "altAddress": this.altAddress,
      "cszAddress": this.cszAddress,
      "note": this.note,
    });

    return mapped;
  }

  Contact.fromMap(Map<String, dynamic> map)
      : this(
            id: map["id"],
            name: map["name"],
            createdOn: map["createdOn"],
            completed: map["completed"],
            image: map["image"],
            imagePath: map["imagePath"],
            title: map["title"],
            company: map["company"],
            email: map["email"],
            phone: map["phone"],
            website: map["website"],
            address: map["address"],
            altAddress: map["altAddress"],
            cszAddress: map["cszAddress"],
            note: map["note"]);

  Contact.fromDbMap(Map<String, dynamic> map)
      : this(
            id: map[dbId],
            name: map[dbName],
            createdOn: DateTime.parse(map[dbCreatedOn]),
            completed: map[dbCompleted] == 1,
            image: Base64Decoder().convert(map[dbImage]),
            imagePath: map[dbImagePath],
            title: map[dbTitle],
            company: map[dbCompany],
            email: map[dbEmail],
            phone: map[dbPhone],
            website: map[dbWebsite],
            address: map[dbAddress],
            altAddress: map[dbAltAddress],
            cszAddress: map[dbCszAddress],
            note: map[dbNote]);

  Contact.copy(Contact c)
      : this(
            id: c.id,
            name: c.name,
            createdOn: c.createdOn,
            completed: c.completed,
            image: c.image,
            imagePath: c.imagePath,
            title: c.title,
            company: c.company,
            email: c.email,
            phone: c.phone,
            website: c.website,
            address: c.address,
            altAddress: c.altAddress,
            cszAddress: c.cszAddress,
            note: c.note);
}
