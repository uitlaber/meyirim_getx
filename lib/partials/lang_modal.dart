import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/ui.dart';

class LangModal extends StatelessWidget {
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
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: appController.getLocale() == 'kk_KZ'
                    ? activeButton()
                    : defaultButton(),
                child: Text(
                  'Қазақша',
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () {
                  Get.updateLocale(Locale('kk', 'KZ'));
                  appController.saveLocale('kz');
                  Get.back();
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: appController.getLocale() == 'ru_RU'
                    ? activeButton()
                    : defaultButton(),
                child: Text(
                  'Русский',
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () {
                  Get.updateLocale(Locale('ru', 'RU'));
                  appController.saveLocale('ru');
                  Get.back();
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  ButtonStyle activeButton() {
    return ElevatedButton.styleFrom(primary: UIColor.green);
  }

  ButtonStyle defaultButton() {
    return ElevatedButton.styleFrom(primary: UIColor.gray);
  }
}
