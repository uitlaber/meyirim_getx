class Photo {
  Photo({
    this.id,
    this.projectsId,
    this.directusFilesId,
  });

  int id;
  int projectsId;
  String directusFilesId;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        projectsId: json["projects_id"],
        directusFilesId: json["directus_files_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "projects_id": projectsId,
        "directus_files_id": directusFilesId,
      };
}
