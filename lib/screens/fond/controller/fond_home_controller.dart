import 'package:get/get.dart';
import 'package:meyirim/controller/app_controller.dart';

class FondHomeController extends GetxController {
  final List<String> tabs = ['заявки', 'ожидающие', 'проекты', 'завершен'];
  final appController = Get.find<AppController>();

  @override
  void onInit() {
    // hideIntro();
    super.onInit();
  }
}
