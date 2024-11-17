import 'package:flutter/material.dart';

class MyTextArea extends StatelessWidget {
  final String hint;
  final String lable;
  final String error;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final String? Function(String?) validation;
  final int maxLines;

  const MyTextArea(
      {super.key,
      required this.hint,
      required this.lable,
      this.error = 'Enter Valid Daat to Field',
      this.textInputType = TextInputType.multiline,
      required this.controller,
      required this.validation,
      this.maxLines = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: validation,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: hint,
            labelText: lable,
            border: OutlineInputBorder()),
        keyboardType: textInputType,
        maxLines: maxLines,
      ),
    );
  }
}
