import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/my_btn.dart';
import 'package:flutter_body_parts/contollers/auth_controller.dart';
import 'package:flutter_body_parts/contollers/body_parts_controller.dart';
import 'package:flutter_body_parts/screens/admin/body_parts/add_body_part.dart';
import 'package:flutter_body_parts/screens/admin/body_parts/body_part_list_screen.dart';
import 'package:flutter_body_parts/screens/admin/users/user_list_screen.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:get/get.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  BodyPartsController bodyPartsController = Get.put(BodyPartsController());
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox(),
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                authController.logoutAdmin();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              )),
        ],
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                onTap: () {
                  Get.to(() => BodyPartListScreen());
                },
                leading: Image.asset(
                  AppImage.logo,
                  height: 50,
                  width: 50,
                ),
                title: Text(
                  "Body Parts",
                  style: AppStyles.textStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.navigate_next,
                  size: 38,
                ),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                onTap: () {
                  Get.to(() => const UserListScreen());
                },
                leading: Image.asset(
                  AppImage.imgUsers,
                  height: 50,
                  width: 50,
                ),
                title: Text(
                  "Manage Users and Chats",
                  style: AppStyles.textStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.navigate_next,
                  size: 38,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyBtn(
                title: 'Add Body Part',
                onTap: () {
                  Get.to(() => const AddBodyPart());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
