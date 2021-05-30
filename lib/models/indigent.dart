import 'dart:convert';
import 'package:meyirim/models/photo.dart';
import 'package:meyirim/core/config.dart' as config;
import 'package:meyirim/models/region.dart';

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
    this.region,
    this.fond,
    this.photos,
    this.dateCreated,
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
  Region region;
  Fond fond;
  List<Photo> photos;
  DateTime dateCreated;

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
        region: json["region_id"] != null
            ? Region.fromJson(json["region_id"])
            : null,
        fond: json["fond_id"] != null ? Fond.fromJson(json["fond_id"]) : null,
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        dateCreated: DateTime.parse(json["date_created"]),
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
        "region": region,
        "fond": fond.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };

  String getPhoto(int index) {
    if (photos.asMap().containsKey(index) &&
        photos[index].directusFilesId != null) {
      return config.API_URL + '/assets/' + '${photos[index].directusFilesId}';
    }
    return config.NO_PHOTO;
  }
}
