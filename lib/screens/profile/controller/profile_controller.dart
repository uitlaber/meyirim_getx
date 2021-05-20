import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:meyirim/core/config.dart' as config;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxDouble amount = 0.0.obs;
  RxDouble referalAmount = 0.0.obs;
  Directus sdk = Get.find<Directus>();
  SharedPreferences prefs = Get.find<SharedPreferences>();

  @override
  Future<void> onInit() async {
    await loadDonatations();
    super.onInit();
  }

  Future<void> loadDonatations() async {
    if (prefs.containsKey('amount')) {
      amount.value = prefs.getDouble('amount');
      referalAmount.value = prefs.getDouble('referal_amount');
    }
    final result =
        await sdk.client.get(config.API_URL + '/custom/user/donations');
    amount.value = double.parse(result.data['amount'].toString());
    referalAmount.value =
        double.parse(result.data['referal_amount'].toString());
    prefs.setDouble('amount', amount.value);
    prefs.setDouble('referal_amount', referalAmount.value);
  }
}
