import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/controller/app_controller.dart';

class InfoModal extends StatelessWidget {
  final appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      )),
    );
  }
}
