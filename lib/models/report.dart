import 'dart:convert';
import 'package:meyirim/core/config.dart' as config;
import 'package:meyirim/models/fond.dart';
import 'package:meyirim/models/project.dart';
import 'photo.dart';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  Report({
    this.id,
    this.description,
    this.title,
    this.status,
    this.videoUrl,
    this.project,
    this.fond,
    this.photos,
  });

  int id;
  String description;
  String title;
  String status;
  String videoUrl;
  Project project;
  Fond fond;
  List<Photo> photos;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        description: json["description"],
        title: json["title"],
        status: json["status"],
        videoUrl: json["video_url"],
        project: Project.fromJson(json["project"]),
        fond: Fond.fromJson(json["fond"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "title": title,
        "status": status,
        "video_url": videoUrl,
        "project": project.toJson(),
        "fond": fond.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };

  List<String> getPhotos() {
    List<String> formattedPhotos;
    photos
        .asMap()
        .forEach((index, photo) => formattedPhotos.add(getPhoto(index)));
    return formattedPhotos;
  }

  String getPhoto(int index) {
    if (photos != null && photos.asMap().containsKey(index)) {
      return config.API_URL + '/assets/' + '${photos[index].directusFilesId}';
    }
    return 'https://via.placeholder.com/400';
  }
}
