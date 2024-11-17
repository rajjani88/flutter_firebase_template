import 'dart:developer';

import 'package:flutter_body_parts/contollers/mypref.dart';
import 'package:flutter_body_parts/models/chat_model.dart';
import 'package:flutter_body_parts/models/user_model.dart';
import 'package:flutter_body_parts/repository/chat_repo.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final RxList<ChatMessage> _chatList = <ChatMessage>[].obs;
  RxList<ChatMessage> get chatList => _chatList;
  Mypref mypref = Mypref();

  final RxBool _loading = false.obs;
  RxBool get loading => _loading;

  final RxBool _loadingChat = false.obs;
  RxBool get loadingChat => _loading;

  ChatRepo chatRepo = ChatRepo();

  //get chat by user id
  getChatByUserId() async {
    _loadingChat.value = true;
    UserModel user = await mypref.getUserData();
    if (_chatList.isNotEmpty) {
      _chatList.value = [];
    }

    chatRepo.getChatByUser(userId: user.uuid ?? '').then(
      (list) {
        _loadingChat.value = false;
        _chatList.value = list;
      },
    ).onError(
      (error, stackTrace) {
        _loadingChat.value = false;
      },
    );
  }

  //admin function get chat for user with id;
  getAdminChats({required String userId}) async {
    print('admin function $userId');
    _loadingChat.value = true;
    if (_chatList.isNotEmpty) {
      _chatList.value = [];
    }

    chatRepo.getChatByUser(userId: userId).then(
      (list) {
        _loadingChat.value = false;
        _chatList.value = list;
      },
    ).onError(
      (error, stackTrace) {
        _loadingChat.value = false;
      },
    );
  }

  assignListner(String userId, {bool isAdmin = false}) async {
    chatRepo.getchatRef(userId).then(
      (docRef) {
        docRef.snapshots().listen(
          (event) {
            if (isAdmin) {
              getAdminChats(userId: userId);
            } else {
              getChatByUserId();
            }
          },
        );
      },
    );
  }

  // asding msg to user
  addNewChatUser(ChatMessage newChat) async {
    _loading.value = true;
    UserModel user = await mypref.getUserData();
    newChat.senderId = user.uuid ?? '';
    newChat.userName = user.name ?? '';
    newChat.receiverId = 'admin';
    newChat.id = _chatList.isEmpty
        ? '0'
        : '${int.parse(_chatList.value.last.id ?? '0') + 1}';
    log('new c hat id : ${newChat.id}');
    chatRepo.addNewChat(user.uuid ?? '', newChat).then(
      (value) {
        _loading.value = false;
      },
    ).onError(
      (error, stackTrace) {
        _loading.value = false;
      },
    );
  }

  addNewChatAdmin(ChatMessage newChat) async {
    _loading.value = true;
    newChat.id = _chatList.isEmpty
        ? '0'
        : '${int.parse(_chatList.value.last.id ?? '0') + 1}';
    log('newAdmin chat id : ${newChat.id}');
    chatRepo.addNewChat(newChat.receiverId ?? '', newChat).then(
      (value) {
        _loading.value = false;
      },
    ).onError(
      (error, stackTrace) {
        _loading.value = false;
      },
    );
  }
}
