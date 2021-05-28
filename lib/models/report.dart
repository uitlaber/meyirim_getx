import 'package:get/get.dart';
import 'dart:convert';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/config.dart' as config;
import 'package:meyirim/models/fond.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/report_translation.dart';
import 'photo.dart';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  Report({
    this.id,
    this.translations,
    this.status,
    this.project,
    this.fond,
    this.photos,
  });

  int id;
  List<ReportTranslation> translations;
  String status;
  Project project;
  Fond fond;
  List<Photo> photos;
  final appController = Get.find<AppController>();

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        translations: (json["translations"].length != null)
            ? List<ReportTranslation>.from(
                json["translations"].map((x) => ReportTranslation.fromJson(x)))
            : [],
        status: json["status"],
        project: Project.fromJson(json["project"]),
        fond: Fond.fromJson(json["fond"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
        "status": status,
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

  String getTranslated(String field) {
    ReportTranslation translated = this.translations.firstWhere(
        (ReportTranslation translation) =>
            translation.languagesCode == appController.getLocale());
    return translated.getProp(field);
  }
}
