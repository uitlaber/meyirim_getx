import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:meyirim/models/report.dart';
import 'package:meyirim/repository/report.dart';

class ReportListController extends GetxController with ScrollMixin {
  ReportRepository _repository = new ReportRepository();

  List<Report> reports = [];
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  int offset = 0;
  int limit = 3;
  int total = 4;

  @override
  void onInit() {
    fetchReports();
    super.onInit();
  }

  @override
  void onClose() {
    reports = [];
    isLoading.value = false;
    hasError.value = false;
    offset = 0;
    total = 4;
    super.onClose();
  }

  Future<void> onEndScroll() async {
    offset = offset + limit;
    if (reports.length < total) await fetchReports();
  }

  Future<void> onTopScroll() {
    // offset = 0;
    // projects = [];
    // fetchProject();
  }

  Future<void> refreshList() async {
    reports = [];
    isLoading.value = false;
    hasError.value = false;
    offset = 0;
    total = 4;
    await fetchReports();
  }

  Future<void> fetchReports() async {
    isLoading.value = true;
    DirectusListResponse result = await _repository.fetchReports(limit, offset);
    try {
      if (result != null) {
        var newReports = List<Report>.from(result.data.map((x) {
          return Report.fromJson(x);
        }));
        reports.addAll(newReports);
        total = result.meta.filterCount;
      }
    } catch (e) {
      print(e);
      hasError.value = true;
    }
    isLoading.value = false;
  }
}