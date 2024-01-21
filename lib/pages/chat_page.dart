import 'package:chatting_app/bloc/chat_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';
import 'package:chatting_app/utils/extension.dart';

import 'package:chatting_app/widgets/loading_widget.dart';
import 'package:chatting_app/widgets/message_input_field.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final ChattingAppModel _chattingAppModel = ChattingAppModel();

class ChatPage extends StatelessWidget {
  const ChatPage(
      {super.key,
      required this.userName,
      required this.userID,
      required this.userProfile});

  final String userName;
  final String userID;
  final String userProfile;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatPageBloc>(
      create: (context) => ChatPageBloc(),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => context.navigateBack(),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          elevation: 0,
          backgroundColor: kSecondaryColor,
          title: Text(
            userName,
            style: TextStyle(
                color: kComponentColor,
                fontFamily: "Raleway",
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: MessageListView(
                otherUserID: userID,
              ),
            ),
            Gap(kSP15x),
            MessageInputView(
              otherUserID: userID,
              otherUserName: userName,
              otherUserProfile: userProfile,
            ),
            Gap(kSP15x)
          ],
        ),
      )),
    );
  }
}

class MessageListView extends StatelessWidget {
  const MessageListView({super.key, required this.otherUserID});

  final String otherUserID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _chattingAppModel.getMessages(
          _firebaseAuth.currentUser!.uid, otherUserID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: LoadingWidget(),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(top: kSP15x),
          child: ListView(
            reverse: true,
            children: snapshot.data!.docs
                .map((document) => MessageItemView(document: document))
                .toList(),
          ),
        );
      },
    );
  }
}

class MessageItemView extends StatelessWidget {
  const MessageItemView({super.key, required this.document});

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    Color bubbleColor = (data['sender_id'] == _firebaseAuth.currentUser!.uid)
        ? kSecondaryColor
        : kChatBubbleColor;

    var alignment = (data['sender_id'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      margin: EdgeInsets.only(left: kSP10x, right: kSP10x, bottom: kSP10x),
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(kSP15x),
        constraints: BoxConstraints(maxWidth: kChatBubbleWidth),
        decoration: BoxDecoration(
            color: bubbleColor, borderRadius: BorderRadius.circular(kSP15x)),
        child: Text(
          data['message'],
          style: TextStyle(
              fontSize: kFontSize18x,
              color: kComponentColor,
              fontFamily: "Raleway"),
        ),
      ),
    );
  }
}

class MessageInputView extends StatelessWidget {
  MessageInputView(
      {super.key,
      required this.otherUserID,
      required this.otherUserName,
      required this.otherUserProfile});

  final String otherUserID;
  final String otherUserName;
  final String otherUserProfile;

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatPageBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 60,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(kSP25x)),
          child: Center(
            child: MessageInputField(
                controller: messageController,
                hintText: 'Enter Message',
                isObscureText: false),
          ),
        ),
        Gap(kSP10x),
        IconButton(
            onPressed: () {
              bloc.otherUserID = otherUserID;
              bloc.sendingMessage = messageController.text;
              bloc.otherUserName = otherUserName;
              bloc.otherUserProfile = otherUserProfile;
              bloc.sendMessages();
              messageController.clear();
            },
            icon: Icon(
              Icons.send,
              size: kSP30x,
              color: Theme.of(context).colorScheme.secondary,
            ))
      ],
    );
  }
}
