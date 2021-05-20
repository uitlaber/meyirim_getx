import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meyirim/core/utils.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/images/logo.svg';
    final Widget logoWidget =
        SvgPicture.asset(assetName, semanticsLabel: 'Meyirim');
    return Scaffold(
      backgroundColor: HexColor('#00D7FF'),
      body: Center(
        child: SingleChildScrollView(
          child: AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 500),
              child: logoWidget),
        ),
      ),
    );
  }
}
