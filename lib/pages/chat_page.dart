import 'package:chatting_app/constants/colors.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.userEmail, required this.userID});

  final String userEmail;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecondaryColor,
        title: Text(
          userEmail,
          style: TextStyle(color: kComponentColor),
        ),
        centerTitle: true,
      ),
    ));
  }
}
