import 'package:get/get.dart';
import 'package:meyirim/screens/search/controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchController());
  }
}
