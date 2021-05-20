import 'package:get/get.dart';
import 'package:meyirim/screens/fond/controller/fond_home_controller.dart';

class FondHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FondHomeController());
  }
}
