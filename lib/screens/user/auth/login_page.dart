import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/my_btn.dart';
import 'package:flutter_body_parts/commons/my_text_fields.dart';
import 'package:flutter_body_parts/contollers/auth_controller.dart';
import 'package:flutter_body_parts/screens/admin/dash_board.dart';
import 'package:flutter_body_parts/screens/user/auth/forgot_password_page.dart';
import 'package:flutter_body_parts/screens/user/auth/privacy_card.dart';
import 'package:flutter_body_parts/screens/user/auth/register_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                      'Welcome back you\'ve been missed!',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // username textfield
                    MyTextFields(
                      controller: emailController,
                      lable: "Email",
                      hint: 'Enter Email',
                      textInputType: TextInputType.emailAddress,
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

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextFields(
                      controller: passwordController,
                      lable: 'Password',
                      hint: 'Enter Password',
                      isPassword: true,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Valid Password';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    // forgot password?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const ForgotPasswordPage());
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
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
                                        if (emailController.text.trim() ==
                                                'admin@gmail.com' &&
                                            passwordController.text.trim() ==
                                                'admin@123') {
                                          authController.setAdminLogin();
                                          Get.back();
                                          Get.to(() => const DashBoard());
                                        } else {
                                          authController.userLogin(
                                              email:
                                                  emailController.text.trim(),
                                              password: passwordController.text
                                                  .trim());
                                        }
                                      }
                                    },
                                    title: 'Login with Email',
                                  ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 50),

                    // not a member? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          //onTap:widget.onTap,
                          onTap: () {
                            Get.to(() => const RegisterPage());
                          },
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
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
