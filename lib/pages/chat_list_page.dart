import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatting_app/bloc/chat_list_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/data/vos/chatted_user_vo.dart';
import 'package:chatting_app/pages/chat_page.dart';
import 'package:chatting_app/utils/enums.dart';
import 'package:chatting_app/widgets/drawer_widget.dart';
import 'package:chatting_app/widgets/error_widget.dart';
import 'package:chatting_app/widgets/loading_state_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatListPageBloc>(
      create: (context) => ChatListPageBloc(),
      child: SafeArea(
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
          body: Selector<ChatListPageBloc, LoadingState>(
              selector: (_, bloc) => bloc.getLoadingState,
              builder: (_, loadingState, __) => LoadingStateWidget(
                  loadingState: loadingState,
                  loadingSuccessWidget: const ChatListView(),
                  errorWidget: const ChatListPageErrorStateItemView())),
        ),
      ),
    );
  }
}

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ChatListPageBloc, List<ChattedUserVO>?>(
      builder: (_, userList, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSP20x),
        child: (userList?.isEmpty ?? true)
            ? Center(
                child: Text(
                  kChatListErrorText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kFontSize18x,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
            : ListView.builder(
                itemBuilder: (_, index) => GestureDetector(
                      onTap: () => PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: ChatPage(
                            userProfile: userList[index].profileURL,
                            userName: userList[index].chattedUserName,
                            userID: userList[index].chattedUserID),
                        withNavBar: false,
                      ),
                      child: ChatListItemView(
                        user: userList![index],
                      ),
                    ),
                itemCount: userList?.length ?? 0),
      ),
      selector: (_, bloc) => bloc.getChatList,
    );
  }
}

class ChatListItemView extends StatelessWidget {
  const ChatListItemView({super.key, required this.user});

  final ChattedUserVO user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kSP30x),
      width: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
          color: kContactBackgroundColor,
          borderRadius: BorderRadius.circular(kSP40x)),
      child: Row(
        children: [
          Container(
            width: kChatListAvatarSquareLength,
            height: kChatListAvatarSquareLength,
            decoration: BoxDecoration(
                color: kAvatarColor,
                borderRadius: BorderRadius.circular(kSP40x)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kSP40x),
              child: CachedNetworkImage(
                imageUrl: user.profileURL,
                placeholder: (context, url) => const Center(
                  child: Icon(Icons.person),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(kSP20x),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.chattedUserName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kFontSize16x,
                    color: kComponentColor),
              ),
              Gap(kSP10x),
              Text(
                user.lastSenderID == _firebaseAuth.currentUser!.uid
                    ? "You: ${user.lastMessage.characters.take(20)}..."
                    : "${user.lastMessage.characters.take(20)}...",
                style: TextStyle(color: kComponentColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ChatListPageErrorStateItemView extends StatelessWidget {
  const ChatListPageErrorStateItemView();

  @override
  Widget build(BuildContext context) {
    return Selector<ChatListPageBloc, String?>(
        selector: (_, bloc) => bloc.getErrorMessage,
        builder: (_, errorMessage, __) =>
            ShowErrorWidget(errorMessage: errorMessage ?? ''));
  }
}
