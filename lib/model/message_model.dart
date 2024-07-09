import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderEmail;
  final String senderId;
  final String message;
  final String receiverId;
  final Timestamp timestamp;

  Message({
    required this.senderEmail,
    required this.senderId,
    required this.message,
    required this.receiverId,
    required this.timestamp,
  });
  Map<String, dynamic> toMap() {
    return {
      "senderEmail": senderEmail,
      "senderId": senderId,
      "message": message,
      "receiverId": receiverId,
      "timestamp": timestamp,
    };
  }
}
