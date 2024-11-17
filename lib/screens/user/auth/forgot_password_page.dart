import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/my_btn.dart';
import 'package:flutter_body_parts/commons/my_text_fields.dart';
import 'package:flutter_body_parts/contollers/auth_controller.dart';
import 'package:flutter_body_parts/screens/user/auth/privacy_card.dart';
import 'package:flutter_body_parts/screens/user/auth/register_page.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  // text editing controllers
  final emailController = TextEditingController();

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),

                    // logo
                    const Icon(
                      Icons.lock,
                      size: 100,
                    ),

                    const SizedBox(height: 50),

                    // welcome back, you've been missed!
                    Text(
                      'Enter Registed Email and We Will sent you Password Reset Link',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // username textfield
                    MyTextFields(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      lable: "Email",
                      hint: 'Enter Email',
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Valid Email';
                        }
                        if (!GetUtils.isEmail(value.toString())) {
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),
                    const PrivacyCard(),
                    const SizedBox(height: 25),

                    // sign in button
                    Obx(
                      () {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            authController.isLoading.value
                                ? const SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: CircularProgressIndicator(),
                                  )
                                : MyBtn(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        authController.sendPasswordResetEmail(
                                            emailController.text.trim());
                                      }
                                    },
                                    title: 'Get Password Reset Link',
                                  ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
