import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/my_btn.dart';
import 'package:flutter_body_parts/commons/my_text_fields.dart';
import 'package:flutter_body_parts/contollers/auth_controller.dart';
import 'package:flutter_body_parts/screens/user/auth/privacy_card.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // text editing controllers
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),

                    // logo
                    const Icon(
                      Icons.lock,
                      size: 50,
                    ),

                    const SizedBox(height: 50),

                    // welcome back, you've been missed!
                    Text(
                      'Let\'s create an account for you ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // email textfield
                    MyTextFields(
                      controller: nameController,
                      hint: 'Enter Full Name',
                      lable: 'Full Name*',
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Full Name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    // email textfield
                    MyTextFields(
                      controller: emailController,
                      hint: 'Enter Email',
                      lable: 'Email*',
                      textInputType: TextInputType.emailAddress,
                      validation: (value) {
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
                      hint: 'Enter Password',
                      isPassword: true,
                      lable: 'Password',
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),
                    MyTextFields(
                      controller: confirmPasswordController,
                      hint: 'Enter Confirm Password',
                      lable: 'Confirm Password',
                      isPassword: true,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        if (confirmPasswordController.text !=
                            passwordController.text) {
                          return 'Confirm Password and Password does not matched';
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
                        return authController.isLoading.value
                            ? const SizedBox(
                                height: 45,
                                width: 45,
                                child: CircularProgressIndicator(),
                              )
                            : MyBtn(
                                title: "Register Now",
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    authController.regiterUser(
                                        name: nameController.text.trim(),
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim());
                                  }
                                },
                              );
                      },
                    ),

                    const SizedBox(height: 50),

                    // not a member? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Text(
                            'Login now',
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
