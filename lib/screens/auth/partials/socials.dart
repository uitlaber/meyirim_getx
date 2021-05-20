import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meyirim/core/utils.dart';

class SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              width: 76,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: HexColor('#37474F')),
              child: SvgPicture.asset('assets/icon/apple.svg', height: 18),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            child: Container(
              width: 76,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: SvgPicture.asset('assets/icon/google.svg', height: 18),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            child: Container(
              width: 76,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: HexColor('#0F279E')),
              child: SvgPicture.asset('assets/icon/facebook.svg', height: 18),
            ),
          )
        ],
      ),
    );
  }
}
