import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_body_parts/models/chat_model.dart';

class ChatRepo {
  String ref = 'chats';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<DocumentReference> getchatRef(String userId) async {
    return db.collection(ref).doc(userId);
  }

  Future<void> addNewChat(String userId, ChatMessage chat) async {
    final chatCollection = db.collection(ref);

    // Check if chat already exists for the user
    final existingChatSnapshot = await chatCollection.doc(userId).get();
    List<ChatMessage> chatlist = [];
    if (existingChatSnapshot.exists) {
      final data = existingChatSnapshot.data();
      final list = data?['chatList'] as List<dynamic>? ?? [];
      chatlist = list
          .map(
            (e) => ChatMessage.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    }

    //add new chat
    chatlist.add(chat);

    //update chat
    await chatCollection.doc(userId).set({
      'chatList': chatlist.map((sub) => sub.toJson()).toList(),
    });
  }

  //get all chat by user id
  Future<List<ChatMessage>> getChatByUser({String userId = '0'}) async {
    final chatCollection = db.collection(ref);
    final existingChatSnapshot = await chatCollection.doc(userId).get();
    List<ChatMessage> chatlist = [];
    if (existingChatSnapshot.exists) {
      final data = existingChatSnapshot.data();
      final list = data?['chatList'] as List<dynamic>? ?? [];
      chatlist = list
          .map(
            (e) => ChatMessage.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    }

    return chatlist;
  }
}
