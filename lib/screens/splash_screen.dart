import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/empty_space.dart';
import 'package:flutter_body_parts/commons/my_btn.dart';
import 'package:flutter_body_parts/screens/admin/dash_board.dart';
import 'package:flutter_body_parts/screens/user/user_splash_screen.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    // authController.initLisner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          verticallGap(size: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyBtn(
                title: 'Admin Login',
                onTap: () {
                  Get.to(() => const DashBoard());
                },
              ),
              verticallGap(),
              MyBtn(
                title: 'User Login',
                bgColo: Colors.white,
                textColor: Colors.blue,
                onTap: () {
                  Get.to(() => const UserSplashScreen());
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
