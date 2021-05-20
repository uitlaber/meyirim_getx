import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customProgressIndicator() {
  return Container(
    child: Center(
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: CircularProgressIndicator()),
    ),
  );
}

Widget customCenteredMessage(String msg) {
  return Container(
    child: Center(
      child: Text(msg.tr),
    ),
  );
}
