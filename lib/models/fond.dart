import 'package:meyirim/core/config.dart' as config;
import 'package:meyirim/models/region.dart';
import 'package:meyirim/repository/region.dart';

class Fond {
  Fond({
    this.firstName,
    this.regionId,
    this.id,
    this.email,
    this.title,
    this.description,
    this.location,
    this.avatar,
  });

  dynamic firstName;
  int regionId;
  String id;
  String email;
  String title;
  dynamic description;
  dynamic location;
  String avatar;
  Region region;

  factory Fond.fromJson(Map<String, dynamic> json) => Fond(
        firstName: json["first_name"],
        regionId: json["region_id"],
        id: json["id"],
        email: json["email"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "region_id": regionId,
        "id": id,
        "email": email,
        "title": title,
        "description": description,
        "location": location,
        "avatar": avatar,
      };

  get getAvatar {
    return config.API_URL + '/assets/' + avatar;
  }

  Future<Region> getRegion() async {
    final regionRepository = RegionRepository();
    return regionRepository.findRegion(this.regionId);
  }
}
