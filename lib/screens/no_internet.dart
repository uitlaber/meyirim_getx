import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meyirim/core/utils.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/icon/no-wifi.svg';
    return Scaffold(
      backgroundColor: HexColor('#00D7FF'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                assetName,
                width: 100,
              ),
              SizedBox(height: 15),
              Text(
                'Нет интернета'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
