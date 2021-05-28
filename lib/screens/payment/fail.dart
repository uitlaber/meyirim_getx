import 'package:flutter/material.dart';
import 'package:meyirim/core/utils.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PaymentFailScreen extends StatelessWidget {
  String title = 'Произошла ошибка'.tr;
  String message = 'Пожалуйста, повторите попытку позже.'.tr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#FF2D55'),
        appBar: AppBar(
          leading: new Container(),
          backgroundColor: HexColor('#FF2D55'),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.close, size: 32),
                color: Colors.white,
                onPressed: () => Get.back())
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 50, color: Colors.white),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
