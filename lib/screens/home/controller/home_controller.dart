import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meyirim/core/service/directus.dart';

class HomeController extends GetxController {
  final firstStart = true.obs;
  final List<String> tabs = ['лента', 'завершенные', 'отчеты'];

  @override
  void onInit() {
    hideIntro();

    super.onInit();
  }

  void hideIntro() {
    Timer(Duration(seconds: 3), () {
      firstStart.value = false;
    });
  }
}
