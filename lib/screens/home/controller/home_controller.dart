import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/service/directus.dart';

class HomeController extends GetxController {
  final List<String> tabs = ['лента', 'завершенные', 'отчеты'];
  final appController = Get.find<AppController>();

  @override
  void onInit() {
    hideIntro();
    super.onInit();
  }

  void hideIntro() {
    Timer(Duration(seconds: 3), () {
      appController.firstStart.value = false;
    });
  }
}
