import 'dart:convert';

ReportTranslation reportTranslationFromJson(String str) =>
    ReportTranslation.fromJson(json.decode(str));

String reportTranslationToJson(ReportTranslation data) =>
    json.encode(data.toJson());

class ReportTranslation {
  ReportTranslation({
    this.id,
    this.projectsId,
    this.languagesCode,
    this.title,
    this.description,
    this.videoUrl,
  });

  int id;
  int projectsId;
  String languagesCode;
  String title;
  String description;
  String videoUrl;

  factory ReportTranslation.fromJson(Map<String, dynamic> json) =>
      ReportTranslation(
        id: json["id"],
        projectsId: json["projects_id"],
        languagesCode: json["languages_code"],
        title: json["title"],
        description: json["description"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "projects_id": projectsId,
        "languages_code": languagesCode,
        "title": title,
        "description": description,
        "video_url": videoUrl,
      };

  dynamic getProp(String key) => <String, dynamic>{
        'title': title,
        'description': description,
        'video_url': videoUrl,
      }[key];
}