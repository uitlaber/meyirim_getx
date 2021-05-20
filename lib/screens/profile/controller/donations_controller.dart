import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:meyirim/models/donation.dart';
import 'package:meyirim/repository/donation.dart';

abstract class DonationsExtController extends GetxController with ScrollMixin {
  RxBool isReferal;
  RxList<Donation> donations;
  RxBool isLoading;
  RxBool hasError;
  int offset;
  int limit;
  int total;
  Directus sdk;

  Future<void> refreshList();
  Future<void> fetchDonations();
}

class DonationsController extends DonationsExtController {
  @override
  RxBool isReferal = false.obs;
  DonationRepository _repository = new DonationRepository();
  RxList<Donation> donations = <Donation>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  int offset = 0;
  int limit = 7;
  int total = 8;
  Directus sdk = Get.find<Directus>();

  Future<void> refreshList() async {
    donations.clear();
    isLoading.value = false;
    hasError.value = false;
    offset = 0;
    total = 8;
    fetchDonations();
  }

  @override
  Future<void> onEndScroll() async {
    offset = offset + limit;
    if (donations.length < total) await fetchDonations();
  }

  @override
  Future<void> onTopScroll() async {}

  @override
  Future<void> onInit() async {
    fetchDonations();
    super.onInit();
  }

  Future<void> fetchDonations() async {
    isLoading.value = true;
    DirectusListResponse result =
        await _repository.fetchDonations(isReferal.value, limit, offset);
    try {
      var newDonations = List<Donation>.from(result.data.map((x) {
        return Donation.fromJson(x);
      }));

      donations.addAll(newDonations);
      total = result.meta.filterCount;
    } catch (e) {
      print(e);
      hasError.value = true;
    }
    isLoading.value = false;
  }
}

class DonationsReferalController extends DonationsExtController {
  @override
  RxBool isReferal = true.obs;
  DonationRepository _repository = new DonationRepository();
  RxList<Donation> donations = <Donation>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  int offset = 0;
  int limit = 7;
  int total = 8;
  Directus sdk = Get.find<Directus>();

  Future<void> refreshList() async {
    donations.clear();
    isLoading.value = false;
    hasError.value = false;
    offset = 0;
    total = 8;
    fetchDonations();
  }

  @override
  Future<void> onEndScroll() async {
    offset = offset + limit;
    if (donations.length < total) await fetchDonations();
  }

  @override
  Future<void> onTopScroll() async {}

  @override
  Future<void> onInit() async {
    fetchDonations();
    super.onInit();
  }

  Future<void> fetchDonations() async {
    isLoading.value = true;
    DirectusListResponse result =
        await _repository.fetchDonations(isReferal.value, limit, offset);
    try {
      if (result != null) {
        var newDonations = List<Donation>.from(result.data.map((x) {
          return Donation.fromJson(x);
        }));
        donations.addAll(newDonations);
        total = result.meta.filterCount;
      }
    } catch (e) {
      print(e);
      hasError.value = true;
    }
    isLoading.value = false;
  }
}
