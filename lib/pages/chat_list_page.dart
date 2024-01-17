import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          drawer: DrawerWidget(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 1,
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              "Chats",
              style: TextStyle(
                  color: kAppBarComponentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: kFontSize24x),
            ),
            toolbarHeight: kSP70x,
            actions: [
              Builder(builder: (buttonContext) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(buttonContext).openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: kSP10x),
                    child: Icon(
                      Icons.menu_outlined,
                      color: kAppBarComponentColor,
                    ),
                  ),
                );
              }),
            ],
          ),
          body: Center(
            child: Text(
              "no Chats For Now",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: kFontSize18x,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          )),
    );
  }
}
