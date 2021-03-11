import 'package:directus/directus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/repository/project.dart';

class SearchController extends GetxController with ScrollMixin {
  ProjectRepository _repository = new ProjectRepository();
  final searchController = TextEditingController();

  RxString query = ''.obs;
  // ignore: deprecated_member_use
  RxList<Project> projects = List<Project>().obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  int offset = 0;
  int limit = 3;
  int total = 4;

  @override
  void onClose() {
    projects.clear();
    isLoading.value = false;
    hasError.value = false;
    offset = 0;
    total = 4;
    super.onClose();
  }

  Future<void> refreshList() async {
    projects.clear();
    isLoading.value = false;
    hasError.value = false;
    offset = 0;
    total = 4;
    searchProjects();
  }

  Future<void> searchProjects() async {
    if (query.value?.isEmpty ?? true) return;
    isLoading.value = true;
    DirectusListResponse result =
        await _repository.searchProjects(query, limit, offset, false);
    try {
      if (result != null) {
        final newProjects = List<Project>.from(result.data.map((x) {
          return Project.fromJson(x);
        }));
        projects.addAll(newProjects);
        total = result.meta.filterCount;
      }
    } catch (e) {
      print(e);
      hasError.value = true;
    }
    isLoading.value = false;
  }

  @override
  Future<void> onEndScroll() async {
    offset = offset + limit;
    if (projects.length < total) await searchProjects();
  }

  @override
  Future<void> onTopScroll() {
    // TODO: implement onTopScroll
    throw UnimplementedError();
  }
}
