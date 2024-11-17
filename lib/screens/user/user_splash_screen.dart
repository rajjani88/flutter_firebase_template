import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_body_parts/contollers/auth_controller.dart';
import 'package:flutter_body_parts/contollers/mypref.dart';
import 'package:flutter_body_parts/screens/admin/dash_board.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:get/get.dart';

class UserSplashScreen extends StatefulWidget {
  const UserSplashScreen({super.key});

  @override
  State<UserSplashScreen> createState() => _UserSplashScreenState();
}

class _UserSplashScreenState extends State<UserSplashScreen> {
  AuthController authController = Get.put(AuthController());
  Mypref pref = Mypref();

  @override
  void initState() {
    super.initState();
    authController.initLisner();
    Timer(
      const Duration(seconds: 3),
      () {
        pref.isAdminLogin().then(
          (isAdmin) {
            if (isAdmin) {
              Get.back();
              Get.to(() => const DashBoard());
            } else {
              authController.checkLogin();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(AppImage.logo),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {
          //         authController.checkLogin();
          //       },
          //       child:
          //           Text('Continue With Email', style: AppStyles.textStyle()),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
