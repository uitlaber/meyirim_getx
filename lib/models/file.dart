// To parse this JSON data, do
//
//     final fileModel = fileModelFromJson(jsonString);

import 'dart:convert';

FileModel fileModelFromJson(String str) => FileModel.fromJson(json.decode(str));

String fileModelToJson(FileModel data) => json.encode(data.toJson());

class FileModel {
  FileModel({
    this.id,
    this.storage,
    this.filenameDisk,
    this.filenameDownload,
    this.title,
    this.type,
    this.filesize,
    this.width,
    this.height,
  });

  String id;
  String storage;
  String filenameDisk;
  String filenameDownload;
  String title;
  String type;
  int filesize;
  int width;
  int height;

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        id: json["id"],
        storage: json["storage"],
        filenameDisk: json["filename_disk"],
        filenameDownload: json["filename_download"],
        title: json["title"],
        type: json["type"],
        filesize: json["filesize"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "storage": storage,
        "filename_disk": filenameDisk,
        "filename_download": filenameDownload,
        "title": title,
        "type": type,
        "filesize": filesize,
        "width": width,
        "height": height,
      };
}
