import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/my_btn.dart';
import 'package:flutter_body_parts/commons/my_snack_msg.dart';
import 'package:flutter_body_parts/commons/my_text_fields.dart';
import 'package:flutter_body_parts/contollers/auth_controller.dart';
import 'package:flutter_body_parts/contollers/home_controller.dart';
import 'package:flutter_body_parts/models/user_model.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();

  HomeController homeController = Get.find<HomeController>();

  initData() {
    nameCont.text = homeController.userModel.value.name ?? '';
    phoneCont.text = homeController.userModel.value.phone ?? '';
    emailCont.text = homeController.userModel.value.email ?? '';
  }

  //onsave click
  void onSave() {
    if (nameCont.text.isEmpty) {
      showMySnak(msg: 'Name Can not be empty');
      return;
    } else if (phoneCont.text.isEmpty) {
      showMySnak(msg: 'Phone Can not be empty');
      return;
    } else if (emailCont.text.isEmpty) {
      showMySnak(msg: 'Email Can not be empty');
      return;
    } else {
      UserModel newData = UserModel(
        uuid: homeController.userModel.value.uuid,
        name: nameCont.text.trim(),
        phone: phoneCont.text.trim(),
        email: emailCont.text.trim(),
      );
      homeController.updateProfile(newData);
    }
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.find<AuthController>().userLogut();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ))
          ],
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          AppImage.imgUserOfficeMan,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFields(
                  controller: nameCont,
                  lable: 'Name*',
                  hint: 'Enter Name',
                  validation: (val) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFields(
                  controller: phoneCont,
                  hint: 'Enter Phone',
                  lable: 'Phone*',
                  validation: (val) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFields(
                  controller: emailCont,
                  hint: 'Enter Email',
                  lable: 'Email*',
                  validation: (p0) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => homeController.isLoading.value
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyBtn(
                              onTap: onSave,
                              title: 'Save Profile',
                            ),
                            // MyBtn(
                            //   onTap: () {},
                            //   title: 'Change Password',
                            //   bgColo: Colors.black,
                            // )
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
