import 'package:get/get.dart';
import 'package:meyirim/controller/app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
  }
}
