import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/utils.dart';

// ignore: must_be_immutable
class PaymentSuccessScreen extends StatelessWidget {
  String title = 'Спасибо!';
  String message =
      'Благотворительный фонд выражает искреннюю благодарность за вашу помощь.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#41BC73'),
        appBar: AppBar(
          leading: new Container(),
          backgroundColor: HexColor('#41BC73'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 100, color: Colors.white),
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
        ));
  }
}
