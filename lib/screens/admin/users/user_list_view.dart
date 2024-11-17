import 'package:flutter/material.dart';
import 'package:flutter_body_parts/contollers/auth_controller.dart';
import 'package:flutter_body_parts/screens/admin/users/user_card.dart';
import 'package:get/get.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      builder: (controller) {
        return controller.loadingUsers.value
            ? const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.userList.length,
                itemBuilder: (context, index) {
                  return UserCard(
                    user: controller.userList[index],
                  );
                },
              );
      },
    );
  }
}
