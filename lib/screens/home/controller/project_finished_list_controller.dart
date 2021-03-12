import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/repository/project.dart';

class ProjectFinishedListController extends GetxController with ScrollMixin {
  ProjectRepository _repository = new ProjectRepository();

  RxList<Project> projects = <Project>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  int offset = 0;
  int limit = 3;
  int total = 4;

  @override
  Future<void> onInit() async {
    await fetchProject();
    super.onInit();
  }

  @override
  void onClose() {
    projects.clear();
    isLoading.value = false;
    hasError.value = false;
    offset = 0;
    total = 4;
    super.onClose();
  }

  Future<void> onEndScroll() async {
    offset = offset + limit;
    if (projects.length < total) await fetchProject();
  }

  Future<void> onTopScroll() {
    // offset = 0;
    // projects = [];
    // fetchProject();
    return null;
  }

  Future<void> refreshList() async {
    projects.clear();
    isLoading.value = false;
    hasError.value = false;
    offset = 0;
    total = 4;
    await fetchProject();
  }

  Future<void> fetchProject() async {
    isLoading.value = true;
    DirectusListResponse result =
        await _repository.fetchProjects(limit, offset, true);
    try {
      var newProjects = List<Project>.from(result.data.map((x) {
        return Project.fromJson(x);
      }));
      projects.addAll(newProjects);
      total = result.meta.filterCount;
    } catch (e) {
      print(e);
      hasError.value = true;
    }
    isLoading.value = false;
  }
}
