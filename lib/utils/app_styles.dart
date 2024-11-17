import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle textStyle(
      {double fontSize = 16,
      Color color = Colors.black,
      FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }

  static TextStyle textStyle14({Color color = Colors.black}) {
    return TextStyle(fontSize: 14, color: color);
  }

  static TextStyle textStyle14Bold({Color color = Colors.black}) {
    return TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color);
  }
}
