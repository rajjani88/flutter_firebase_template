import 'package:flutter/material.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';

class MyBtn extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color bgColo;
  final Color textColor;
  final double textSize;
  final FontWeight textFontWeight;
  const MyBtn(
      {super.key,
      required this.title,
      required this.onTap,
      this.bgColo = Colors.blue,
      this.textColor = Colors.white,
      this.textSize = 16,
      this.textFontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColo,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      onPressed: onTap,
      child: Text(title,
          style: AppStyles.textStyle(
              fontSize: textSize,
              color: textColor,
              fontWeight: textFontWeight)),
    );
  }
}
