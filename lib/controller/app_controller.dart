import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meyirim/models/user.dart';

class AppController extends GetxController {
  RxBool firstStart = true.obs;
  RxBool isLogged = false.obs;
  Directus sdk = Get.find<Directus>();
  DirectusUser user;

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

  bool checkAuth() {
    final result = sdk.auth.isLoggedIn;
    isLogged.value = result;
    return result;
  }

  Future<void> login() async {
    print('Login');
    await sdk.auth.login(email: 'devillomsoft@gmail.com', password: '100102');
    isLogged.value = true;
    userInfo();
  }

  Future<void> logout() async {
    print('Logout');
    await sdk.auth.logout();
    isLogged.value = false;
  }

  Future<void> userInfo() async {
    DirectusResponse<DirectusUser> result = await sdk.auth.currentUser?.read();
    user = result.data;
  }
}
