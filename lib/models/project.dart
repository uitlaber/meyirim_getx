import 'package:get/get.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/config.dart' as config;
import 'package:meyirim/models/project_translation.dart';
import 'dart:convert';
import 'fond.dart';
import 'photo.dart';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project({
    this.status,
    this.collectedAmount,
    this.isFinished,
    this.id,
    this.dateCreated,
    this.translations,
    this.requiredAmount,
    this.donationsCount,
    this.photos,
    this.fond,
  });

  String status;
  bool isFinished;
  int id;
  DateTime dateCreated;
  List<ProjectTranslation> translations;
  double requiredAmount;
  int donationsCount;
  double collectedAmount;
  List<Photo> photos;
  Fond fond;
  final appController = Get.find<AppController>();

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        status: json["status"],
        isFinished: json["is_finished"],
        id: json["id"],
        dateCreated: DateTime.parse(json["date_created"]),
        translations: (json["translations"].length != null)
            ? List<ProjectTranslation>.from(
                json["translations"].map((x) => ProjectTranslation.fromJson(x)))
            : [],
        requiredAmount: double.parse(json["required_amount"]),
        donationsCount: json["donations_count"],
        collectedAmount: double.parse(json["collected_amount"]),
        photos: (json["photos"].length != null)
            ? List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x)))
            : [],
        fond: json["fond"] != null ? Fond.fromJson(json["fond"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "collected_amount": collectedAmount,
        "is_finished": isFinished,
        "id": id,
        "date_created": dateCreated.toIso8601String(),
        "required_amount": requiredAmount,
        "donations_count": donationsCount,
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "fond": fond.toJson(),
      };

  List<String> getPhotos() {
    List<String> formattedPhotos;
    photos
        .asMap()
        .forEach((index, photo) => formattedPhotos.add(getPhoto(index)));
    return formattedPhotos;
  }

  String getPhoto(int index) {
    if (photos.asMap().containsKey(index) &&
        photos[index].directusFilesId != null) {
      return config.API_URL + '/assets/' + '${photos[index].directusFilesId}';
    }
    return config.NO_PHOTO;
  }

  String getTranslated(String field) {
    ProjectTranslation translated = this.translations.firstWhere(
        (ProjectTranslation translation) =>
            translation.languagesCode == appController.getLocale());
    return translated.getProp(field);
  }
}
