import 'package:chatting_app/bloc/home_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/pages/chat_page.dart';
import 'package:chatting_app/pages/profile_page.dart';
import 'package:chatting_app/utils/enums.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/widgets/error_widget.dart';
import 'package:chatting_app/widgets/loading_state_widget.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          leading: null,
          elevation: 0,
          backgroundColor: kSecondaryColor,
          title: Text(
            "Contacts",
            style: TextStyle(
                color: kComponentColor,
                fontWeight: FontWeight.bold,
                fontSize: kFontSize24x),
          ),
          toolbarHeight: kSP70x,
          actions: [
            GestureDetector(
              onTap: () {
                context.navigateToNext(ProfilePage());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: kSP10x),
                child: Icon(
                  Icons.account_box,
                  color: kComponentColor,
                ),
              ),
            ),
          ],
        ),
        body: Selector<HomePageBloc, LoadingState>(
            selector: (_, bloc) => bloc.getLoadingState,
            builder: (_, loadingState, __) => LoadingStateWidget(
                loadingState: loadingState,
                loadingSuccessWidget: const HomePageUserListView(),
                errorWidget: const HomePageErrorStateItemView())),
      )),
    );
  }
}

class HomePageUserListView extends StatelessWidget {
  const HomePageUserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<UserVO>?>(
      builder: (_, userList, __) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: kSP20x, vertical: kSP30x),
        child: (userList?.isEmpty ?? true)
            ? Center(
                child: Text(
                  kUserListErrorText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: kFontSize18x),
                ),
              )
            : ListView.separated(
                itemBuilder: (_, index) => GestureDetector(
                      onTap: () => context.navigateToNext(ChatPage(
                          userName: userList![index].name,
                          userID: userList[index].uid)),
                      child:
                          UserItemView(userName: userList?[index].name ?? ''),
                    ),
                separatorBuilder: (_, index) => const Gap(kSP25x),
                itemCount: userList?.length ?? 0),
      ),
      selector: (_, bloc) => bloc.getUserList,
    );
  }
}

class UserItemView extends StatelessWidget {
  const UserItemView({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
          color: kContactBackgroundColor,
          borderRadius: BorderRadius.circular(kSP30x)),
      child: Row(
        children: [
          Container(
            width: kUserAvatarSquareLength,
            height: kUserAvatarSquareLength,
            decoration: BoxDecoration(
                color: kAvatarColor,
                borderRadius: BorderRadius.circular(kSP30x)),
            child: Center(
              child: Icon(
                CupertinoIcons.profile_circled,
                size: kSP35x,
              ),
            ),
          ),
          Gap(kSP20x),
          Text(
            userName,
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: kFontSize16x),
          ),
        ],
      ),
    );
  }
}

class HomePageErrorStateItemView extends StatelessWidget {
  const HomePageErrorStateItemView();

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, String?>(
        selector: (_, bloc) => bloc.getErrorMessage,
        builder: (_, errorMessage, __) =>
            ShowErrorWidget(errorMessage: errorMessage ?? ''));
  }
}
