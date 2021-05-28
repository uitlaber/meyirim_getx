import 'dart:convert';

ProjectTranslation projectTranslationFromJson(String str) =>
    ProjectTranslation.fromJson(json.decode(str));

String projectTranslationToJson(ProjectTranslation data) =>
    json.encode(data.toJson());

class ProjectTranslation {
  ProjectTranslation({
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

  factory ProjectTranslation.fromJson(Map<String, dynamic> json) =>
      ProjectTranslation(
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
