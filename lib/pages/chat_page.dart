import 'package:chatting_app/constants/colors.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.userName, required this.userID});

  final String userName;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: Text(''),
        elevation: 0,
        backgroundColor: kSecondaryColor,
        title: Text(
          userName,
          style: TextStyle(color: kComponentColor),
        ),
        centerTitle: true,
      ),
    ));
  }
}
