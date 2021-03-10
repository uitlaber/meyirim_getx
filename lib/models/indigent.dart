import 'dart:convert';
import 'package:meyirim/models/photo.dart';

import 'fond.dart';

Indigent indigentFromJson(String str) => Indigent.fromJson(json.decode(str));

String indigentToJson(Indigent data) => json.encode(data.toJson());

class Indigent {
  Indigent({
    this.id,
    this.fullname,
    this.name,
    this.surname,
    this.patronymic,
    this.address,
    this.phone,
    this.note,
    this.isVerifed,
    this.location,
    this.iin,
    this.regionId,
    this.fond,
    this.photos,
  });

  int id;
  String fullname;
  String name;
  String surname;
  String patronymic;
  String address;
  String phone;
  String note;
  bool isVerifed;
  String location;
  String iin;
  int regionId;
  Fond fond;
  List<Photo> photos;

  factory Indigent.fromJson(Map<String, dynamic> json) => Indigent(
        id: json["id"],
        fullname: json["fullname"],
        name: json["name"],
        surname: json["surname"],
        patronymic: json["patronymic"],
        address: json["address"],
        phone: json["phone"],
        note: json["note"],
        isVerifed: json["is_verifed"],
        location: json["location"],
        iin: json["iin"],
        regionId: json["region_id"],
        fond: Fond.fromJson(json["fond_id"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "name": name,
        "surname": surname,
        "patronymic": patronymic,
        "address": address,
        "phone": phone,
        "note": note,
        "is_verifed": isVerifed,
        "location": location,
        "iin": iin,
        "region_id": regionId,
        "fond": fond.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}
