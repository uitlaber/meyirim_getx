import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    this.key,
    this.ruRu,
    this.kkKz,
  });

  String key;
  String ruRu;
  String kkKz;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        key: json["key"],
        ruRu: json["ru_RU"],
        kkKz: json["kk_KZ"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "ru_RU": ruRu,
        "kk_KZ": kkKz,
      };

  String getMessage(String lang) {
    var result;
    switch (lang) {
      case 'kk_KZ':
        result = this.kkKz;
        break;
      case 'ru_RU':
        result = this.ruRu;
        break;
    }

    return result;
  }
}
