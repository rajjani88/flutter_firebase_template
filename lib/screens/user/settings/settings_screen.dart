import 'package:flutter/material.dart';
import 'package:flutter_body_parts/contollers/auth_controller.dart';
import 'package:flutter_body_parts/screens/user/settings/profile_screen.dart';
import 'package:flutter_body_parts/screens/user/settings/widgets/settings_item_card.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:flutter_body_parts/utils/app_string.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:flutter_body_parts/utils/open_url.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SettingsItemCard(
                title: 'Profile',
                img: AppImage.imgUserOfficeMan,
                onTap: () {
                  Get.to(() => const ProfileScreen());
                },
              ),
              const SizedBox(
                height: 14,
              ),
              const Divider(),
              const SizedBox(
                height: 14,
              ),
              const SizedBox(
                height: 14,
              ),
              SettingsItemCard(
                title: 'Privacy Policy',
                img: AppImage.imgCondtions,
                onTap: () {
                  openUrl(AppString.privayUrl);
                },
              ),
              const SizedBox(
                height: 14,
              ),
              SettingsItemCard(
                title: 'Terms and Conditions',
                img: AppImage.imgTerm,
                onTap: () {
                  openUrl(AppString.termsUrl);
                },
              ),
              const SizedBox(
                height: 14,
              ),
              SettingsItemCard(
                title: 'Logout',
                img: AppImage.imgLogout,
                onTap: () {
                  authController.userLogut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
