import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_body_parts/models/user_model.dart';

class UserRepo {
  FirebaseFirestore db = FirebaseFirestore.instance;

  //ref titles
  String userCollection = 'users';

  //add User
  Future<UserModel> addUser(UserModel user) async {
    final docRef = await db
        .collection(userCollection)
        .doc(user.uuid)
        .set(user.toFirestore());
    return user;
  }

  Future<UserModel?> getUserFromUuid(String uuid) async {
    final docRef = await db.collection(userCollection).doc(uuid).get();
    UserModel userModel = UserModel.fromFirestore(docRef, null);
    return userModel;
  }

  Future<List<UserModel>> getAllUsers() async {
    final usersCollection = db.collection(userCollection);

    // Get all user documents
    final querySnapshot = await usersCollection.get();

    // Convert documents to UserModel objects
    final userList =
        querySnapshot.docs.map((doc) => UserModel.fromFirestore2(doc)).toList();
    log('users : $userList');
    return userList;
  }
}
