// To parse this JSON data, do
//
//     final config = configFromJson(jsonString);

import 'dart:convert';

Config configFromJson(String str) => Config.fromJson(json.decode(str));

String configToJson(Config data) => json.encode(data.toJson());

class Config {
  Config({
    this.id,
    this.key,
    this.value,
  });

  int id;
  String key;
  String value;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
      };
}
