import 'package:flutter/material.dart';
import 'package:flutter_body_parts/contollers/body_parts_controller.dart';
import 'package:flutter_body_parts/contollers/chat_controller.dart';
import 'package:flutter_body_parts/contollers/home_controller.dart';
import 'package:flutter_body_parts/screens/user/chat/chat_screen.dart';
import 'package:flutter_body_parts/screens/user/home/widgets/user_body_part_list_view.dart';
import 'package:flutter_body_parts/screens/user/settings/settings_screen.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BodyPartsController controller = Get.put(BodyPartsController());
  ChatController chatController = Get.put(ChatController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        leading: const SizedBox(),
        centerTitle: true,
        title: Text(
          'Home',
          style: AppStyles.textStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => ChatPage());
              },
              icon: const Icon(Icons.question_answer)),
          IconButton(
              onPressed: () {
                Get.to(() => const SettingsScreen());
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [Expanded(child: UserBodyPartListView())],
      ),
    );
  }
}
