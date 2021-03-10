// To parse this JSON data, do
//
//     final region = regionFromJson(jsonString);

import 'dart:convert';

Region regionFromJson(String str) => Region.fromJson(json.decode(str));

String regionToJson(Region data) => json.encode(data.toJson());

class Region {
  Region({
    this.id,
    this.name,
    this.parentId,
    this.countryId,
    this.sort,
  });

  int id;
  String name;
  dynamic parentId;
  int countryId;
  int sort;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        countryId: json["country_id"],
        sort: json["sort"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "country_id": countryId,
        "sort": sort,
      };

  static Map<String, dynamic> toMap(Region region) => {
        'id': region.id,
        'name': region.name,
        'parentId': region.parentId,
        'countryId': region.countryId,
        'sort': region.sort,
      };

  static String encode(List<Region> regions) => json.encode(
        regions
            .map<Map<String, dynamic>>((region) => Region.toMap(region))
            .toList(),
      );

  static List<Region> decode(String regions) =>
      (json.decode(regions) as List<dynamic>)
          .map<Region>((item) => Region.fromJson(item))
          .toList();
}
