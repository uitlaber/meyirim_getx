import 'package:flutter/material.dart';
import 'package:meyirim/core/utils.dart';

class UIColor {
  static Color blue = HexColor('#00D7FF');
  static Color green = HexColor('#41BC73');
  static Color gray = HexColor('#F2F2F7');
  static Color red = HexColor('#FF2D55');
  static Color black = HexColor('#182B44');
  static Color textGray = Colors.grey[600];
}

InputDecoration uiInputDecoration({hintText: '', EdgeInsetsGeometry padding}) {
  return InputDecoration(
      contentPadding:
          padding == null ? EdgeInsets.only(left: 20.0, right: 20.0) : padding,
      border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
          borderSide: new BorderSide(color: Colors.transparent)),
      enabledBorder: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
          borderSide: new BorderSide(color: Colors.transparent)),
      filled: true,
      hintStyle: new TextStyle(color: Colors.grey[600]),
      hintText: hintText,
      fillColor: Colors.white);
}

Widget uiButton({VoidCallback onPressed, String text}) {
  return ButtonTheme(
    height: 50.0,
    buttonColor: UIColor.green,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      // side: BorderSide(color: Colors.red)
    ),
    child: SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
