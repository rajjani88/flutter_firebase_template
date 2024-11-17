import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/my_snack_msg.dart';
import 'package:flutter_body_parts/contollers/mypref.dart';
import 'package:flutter_body_parts/models/user_model.dart';
import 'package:flutter_body_parts/repository/user_repo.dart';
import 'package:flutter_body_parts/screens/splash_screen.dart';
import 'package:flutter_body_parts/screens/user/auth/login_page.dart';
import 'package:flutter_body_parts/screens/user/home/home_screen.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserRepo userRepo = UserRepo();
  Mypref mypref = Mypref();

  User? user;
  Rx<bool> isLoading = false.obs;

  final Rx<bool> _loadingUsers = false.obs;
  Rx<bool> get loadingUsers => _loadingUsers;

  final RxList<UserModel> _userList = <UserModel>[].obs;
  RxList<UserModel> get userList => _userList;

  initLisner() {
    auth.authStateChanges().listen(
      (userAuth) {
        if (userAuth == null) {
          user = userAuth;
        } else {
          user = userAuth;
        }
      },
    );
  }

  setAdminLogin() {
    mypref.setAdminLogin(isLogin: true);
  }

  logoutAdmin() {
    mypref.setAdminLogin(isLogin: false);
    Get.offAll(() => const SplashScreen());
  }

  checkLogin() {
    if (user == null) {
      Get.to(() => const LoginPage());
    } else {
      Get.to(() => const HomeScreen());
    }
  }

  //create / register user
  regiterUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      isLoading.value = true;
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (creds) {
          if (creds.user != null) {
            userRepo
                .addUser(UserModel(
              uuid: creds.user!.uid,
              name: name,
              phone: '',
              email: email,
            ))
                .then(
              (user) {
                mypref.saveUser(user);
                isLoading.value = false;
                Get.back();
                Get.to(() => const HomeScreen());
              },
            );
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  //login
  userLogin({required String email, required String password}) async {
    try {
      isLoading.value = true;
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (creds) {
          isLoading.value = false;
          if (creds.user != null) {
            userRepo.getUserFromUuid(creds.user!.uid).then(
              (user) {
                log('userName : ${user!.name}');
                mypref.saveUser(user);
                Get.back();
                Get.to(() => const HomeScreen());
              },
            );
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
            title: 'User Not found with this Email and Password.');
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
            title: 'Entered Email or Password is Wrong. Try Again.');
      } else {
        Get.defaultDialog(
          title: 'Entered Email or Password is Wrong. Try Again.',
          content: const SizedBox(),
        );
      }
    }
  }

  //logout
  userLogut() async {
    await auth.signOut();
    Get.offAll(() => const SplashScreen());
  }

  getAllUsers() {
    if (_userList.isNotEmpty) {
      _userList.value = [];
    }
    _loadingUsers.value = true;
    userRepo.getAllUsers().then(
      (list) {
        _loadingUsers.value = false;
        _userList.value = list;
      },
    ).onError(
      (error, stackTrace) {
        _loadingUsers.value = false;
      },
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.back();
      showSuccessdialog(
          title: 'Email Sent.', dec: 'Password reset email sent successfully!');
    } catch (e) {
      print('Error sending password reset email: $e');
    }
  }
}
