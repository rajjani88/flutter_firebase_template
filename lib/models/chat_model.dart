class ChatMessage {
  String? id;
  String? userName;
  String? senderId; // User or Admin ID
  String? receiverId; // User or Admin ID
  String? content;
  DateTime? timestamp;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.userName,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'] as String,
        senderId: json['senderId'] as String,
        receiverId: json['receiverId'] as String,
        userName: json['userName'] as String,
        content: json['content'] as String,
        timestamp:
            DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'senderId': senderId,
        'receiverId': receiverId,
        'userName': userName,
        'content': content,
        'timestamp': timestamp!.millisecondsSinceEpoch,
      };
}
