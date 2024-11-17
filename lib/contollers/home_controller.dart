import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_body_parts/commons/my_snack_msg.dart';
import 'package:flutter_body_parts/contollers/mypref.dart';
import 'package:flutter_body_parts/models/user_model.dart';
import 'package:flutter_body_parts/repository/user_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Mypref mypref = Mypref();
  UserRepo userRepo = UserRepo();

  User? user;
  Rx<bool> isLoading = false.obs;

  Rx<UserModel> userModel = UserModel().obs;

  getUser() {
    mypref.getUserData().then(
      (value) {
        userModel.value = value;
        userModel.refresh();
      },
    );
  }

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

  //profile update
  void updateProfile(UserModel user) {
    isLoading.value = true;
    userRepo.addUser(user).then(
      (value) {
        isLoading.value = false;
        userModel.value = user;
        mypref.saveUser(user);
        showSuccessdialog(
            title: 'Profile Saves !', dec: 'your recent updates saved!');
      },
    ).onError(
      (error, stackTrace) {
        isLoading.value = false;
      },
    );
  }
}
