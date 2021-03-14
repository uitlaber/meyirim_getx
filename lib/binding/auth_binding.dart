import 'package:get/get.dart';
import 'package:meyirim/screens/auth/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(RegisterController());
    Get.put(ResetController());
  }
}
