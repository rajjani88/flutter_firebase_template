import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:get/get.dart';

void showSuccessdialog({
  required String title,
  String dec = '',
}) {
  AwesomeDialog(
          context: Get.context!,
          title: title,
          desc: dec,
          btnOkText: 'Ok',
          dialogType: DialogType.success)
      .show();
}

void showMySnak({
  required String msg,
}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: AppStyles.textStyle(
        color: Colors.red,
      ),
    ),
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.floating,
  ));
}
