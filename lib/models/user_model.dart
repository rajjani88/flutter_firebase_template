import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uuid;
  final String? name;
  final String? phone;
  final String? email;

  UserModel({
    this.uuid,
    this.name,
    this.phone = '',
    this.email,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      uuid: data?['uuid'],
      name: data?['name'],
      phone: data?['phone'],
      email: data?['email'],
    );
  }

  factory UserModel.fromFirestore2(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserModel(
      uuid: data?['uuid'],
      name: data?['name'],
      phone: data?['phone'],
      email: data?['email'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (uuid != null) "uuid": uuid,
      if (name != null) "name": name,
      if (phone != null) "phone": phone,
      if (email != null) "email": email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
        uuid: data['uuid'],
        name: data['name'],
        phone: data['phone'],
        email: data['email'],
      );

  Map<String, dynamic> toJson() => {
        if (uuid != null) "uuid": uuid,
        if (name != null) "name": name,
        if (phone != null) "phone": phone,
        if (email != null) "email": email,
      };
}
