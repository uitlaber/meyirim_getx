import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:meyirim/models/region.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

class AppController extends GetxController {
  RxBool firstStart = true.obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    if (await checkInternet()) {}
    super.onInit();
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('Есть интернет');
      return true;
    } else {
      print('Нет интернета');
      return false;
    }
  }
}
