import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:meyirim/core/config.dart';

class Contacts extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Свяжитесь с нами'.tr,
              style: TextStyle(color: Colors.white))),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: InkWell(
                    onTap: () => launchWhatsapp(),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Row(children: [
                          SvgPicture.asset(
                            'assets/icon/whatsapp.svg',
                            height: 32,
                            width: 32,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Написать в Whatsapp'.tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ]))),
              ),
              SizedBox(height: 15),
              Container(
                child: InkWell(
                    onTap: () => launchTelegram(),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Row(children: [
                          SvgPicture.asset(
                            'assets/icon/telegram.svg',
                            height: 32,
                            width: 32,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Написать в Telegram'.tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ]))),
              )
            ],
          ),
        ),
      ),
    );
  }

  void launchWhatsapp() async {
    await canLaunch(WHATSAPP_URL)
        ? launch(WHATSAPP_URL)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  void launchTelegram() async {
    await canLaunch(TELEGRAM_URL)
        ? launch(TELEGRAM_URL)
        : print(
            "open telegram app link or do a snackbar with notification that there is no telegram installed");
  }
}
