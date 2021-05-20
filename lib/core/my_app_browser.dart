import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:meyirim/controller/app_controller.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  void onExit() {
    print("\n\nBrowser closed!\n\n");
  }
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  MyChromeSafariBrowser(browserFallback);
  final appController = Get.find<AppController>();
  @override
  void onOpened() {
    if (appController.isLoading.isTrue) {
      appController.isLoading.value = false;
      Get.back();
    }
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}
