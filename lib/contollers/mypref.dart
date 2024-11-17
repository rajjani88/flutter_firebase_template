import 'dart:convert';
import 'dart:developer';

import 'package:flutter_body_parts/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mypref {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  String keyUser = 'user';
  String keyAdminLogin = 'admin';

  saveUser(UserModel user) {
    String userJson = jsonEncode(user.toJson());
    log('userjson : ${userJson}');

    prefs.setString(keyUser, userJson);
  }

  Future<UserModel> getUserData() async {
    String userjson = await prefs.getString(keyUser) ?? '';
    UserModel user = UserModel.fromJson(jsonDecode(userjson));
    log('user (pref) : ${user.name}');
    return user;
  }

  //admin login details
  setAdminLogin({bool isLogin = false}) {
    prefs.setBool(keyAdminLogin, isLogin);
  }

  Future<bool> isAdminLogin() async {
    bool isAdmin = await prefs.getBool(keyAdminLogin) ?? false;
    log('isAdminLogin (pref) : ${isAdmin}');
    return isAdmin;
  }
}
