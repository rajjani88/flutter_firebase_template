import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/empty_space.dart';
import 'package:flutter_body_parts/models/user_model.dart';
import 'package:flutter_body_parts/screens/admin/admin_chats/admin_chat_screen.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:get/get.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildRow(
                Icons.account_circle,
                user.name ?? 'NA',
              ),
              Divider(),
              _buildRow(Icons.phone,
                  user.phone!.isEmpty ? 'NA' : user.phone.toString()),
              Divider(),
              _buildRow(
                Icons.email,
                user.email ?? 'NA',
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => AdminChatPage(currentUser: user));
                    },
                    child: const SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.question_answer,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.black54,
        ),
        horizontalGap(),
        Text(
          title,
          style: AppStyles.textStyle14(),
        ),
      ],
    );
  }
}
