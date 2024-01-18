import 'package:cloud_firestore/cloud_firestore.dart';

class MessageVO {
  String senderID;
  String senderEmail;
  String receiverID;
  String message;
  Timestamp timeStamp;

  MessageVO(
      {required this.senderID,
      required this.senderEmail,
      required this.receiverID,
      required this.message,
      required this.timeStamp});

  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderID,
      'sender_email': senderEmail,
      'receiver_id': receiverID,
      'message': message,
      'time_stamp': timeStamp
    };
  }
}
