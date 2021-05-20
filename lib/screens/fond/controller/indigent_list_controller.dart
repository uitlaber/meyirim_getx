import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:meyirim/models/indigent.dart';
import 'package:meyirim/repository/indigent.dart';
import 'package:flutter/material.dart';

class IndigentListController extends GetxController with ScrollMixin {
  IndigentRepository _repository = new IndigentRepository();
  RxList<Indigent> indigents = <Indigent>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  int offset = 0;
  int limit = 9;
  int total = 10;
  //Поиск
  final searchController = TextEditingController();
  RxString query = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchIndigents();
  }

  @override
  void onClose() {
    indigents.clear();
    isLoading.value = false;
    hasError.value = false;
    offset = 0;
    total = 10;
    super.onClose();
  }

  Future<void> onEndScroll() async {
    offset = offset + limit;
    if (indigents.length < total) await fetchIndigents();
  }

  Future<void> refreshList() async {
    indigents.clear();
    isLoading.value = false;
    hasError.value = false;
    offset = 0;
    total = 10;
    await fetchIndigents();
  }

  Future<void> onTopScroll() {
    // offset = 0;
    // projects = [];
    // fetchProject();
    return null;
  }

  Future<void> searchIndigents() async {
    if (query.value?.isEmpty ?? true) return;
    isLoading.value = true;
    DirectusListResponse result =
        await _repository.searchIndigents(query, limit, offset, false);
    try {
      if (result != null) {
        final newIndigents = List<Indigent>.from(result.data.map((x) {
          return Indigent.fromJson(x);
        }));
        indigents.addAll(newIndigents);
        total = result.meta.filterCount;
      }
    } catch (e) {
      print(e);
      hasError.value = true;
    }
    isLoading.value = false;
  }

  Future<void> fetchIndigents() async {
    isLoading.value = true;
    DirectusListResponse result =
        await _repository.fetchIndigents(limit, offset, false);
    try {
      var newIndigents = List<Indigent>.from(result.data.map((x) {
        return Indigent.fromJson(x);
      }));
      indigents.addAll(newIndigents);
      total = result.meta.filterCount;
    } catch (e) {
      print(e);
      hasError.value = true;
    }
    isLoading.value = false;
  }
}
