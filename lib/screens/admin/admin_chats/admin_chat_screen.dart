import 'package:flutter/material.dart';
import 'package:flutter_body_parts/contollers/chat_controller.dart';
import 'package:flutter_body_parts/models/chat_model.dart';
import 'package:flutter_body_parts/models/user_model.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:flutter_body_parts/utils/date_time_helper.dart';
import 'package:get/get.dart';

class AdminChatPage extends StatefulWidget {
  final UserModel currentUser;

  const AdminChatPage({super.key, required this.currentUser});

  @override
  State<AdminChatPage> createState() => _AdminChatPageState();
}

class _AdminChatPageState extends State<AdminChatPage> {
  ChatController controller = Get.put(ChatController());

  TextEditingController chatText = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.getAdminChats(userId: widget.currentUser.uuid ?? '');
    controller.assignListner(widget.currentUser.uuid ?? '', isAdmin: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Chat with ${widget.currentUser.name ?? ''}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child:
                  //  controller.loadingChat.value
                  //     ? const Center(
                  //         child: SizedBox(
                  //           height: 45,
                  //           width: 45,
                  //           child: CircularProgressIndicator(),
                  //         ),
                  //       )
                  //     :

                  ListView.builder(
                itemCount: controller.chatList.length,
                itemBuilder: (context, index) {
                  ChatMessage chatMessage = controller.chatList.value[index];
                  return _buildMessage(
                      chatMessage.senderId == 'admin'
                          ? 'Admin'
                          : chatMessage.userName ?? '',
                      chatMessage.content ?? '',
                      chatMessage.timestamp ?? DateTime.now());
                },
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chatText,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                Obx(
                  () => controller.loading.value
                      ? IconButton(
                          icon: CircularProgressIndicator(),
                          onPressed: null,
                        )
                      : IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            if (chatText.text.isNotEmpty) {
                              controller.addNewChatAdmin(ChatMessage(
                                  id: '0',
                                  senderId: 'admin',
                                  userName: '${widget.currentUser.name}',
                                  receiverId: '${widget.currentUser.uuid}',
                                  content: chatText.text.trim(),
                                  timestamp: DateTime.now()));
                              chatText.clear();
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String sender, String message, DateTime dt) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(sender[0].toUpperCase()),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateTimeHelper.formatDateTime(dt),
                    style: AppStyles.textStyle(fontSize: 12),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
