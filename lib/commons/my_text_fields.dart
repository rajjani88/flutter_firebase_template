import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  final String hint;
  final String lable;
  final String error;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final String? Function(String?) validation;
  final bool isPassword;

  const MyTextFields(
      {super.key,
      required this.hint,
      required this.lable,
      this.error = 'Enter Valid Daat to Field',
      this.textInputType = TextInputType.text,
      required this.controller,
      required this.validation,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validation,
      obscureText: isPassword,
      decoration: InputDecoration(
          hintText: hint, labelText: lable, border: OutlineInputBorder()),
      keyboardType: textInputType,
    );
  }
}
