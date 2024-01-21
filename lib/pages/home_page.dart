import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatting_app/bloc/home_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/pages/chat_page.dart';
import 'package:chatting_app/utils/enums.dart';

import 'package:chatting_app/widgets/drawer_widget.dart';
import 'package:chatting_app/widgets/error_widget.dart';
import 'package:chatting_app/widgets/loading_state_widget.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: DrawerWidget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Contacts",
            style: TextStyle(
                color: kAppBarComponentColor,
                fontWeight: FontWeight.bold,
                fontSize: kFontSize24x,
                fontFamily: "Raleway"),
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
        padding: const EdgeInsets.symmetric(horizontal: kSP20x),
        child: (userList?.isEmpty ?? true)
            ? Center(
                child: Text(
                  kUserListErrorText,
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
                            userProfile: userList![index].profileURL,
                            userName: userList[index].name,
                            userID: userList[index].uid),
                        withNavBar: false,
                      ),
                      child: UserItemView(
                          userName: userList?[index].name ?? '',
                          profileURL: userList?[index].profileURL ?? ''),
                    ),
                itemCount: userList?.length ?? 0),
      ),
      selector: (_, bloc) => bloc.getUserList,
    );
  }
}

class UserItemView extends StatelessWidget {
  const UserItemView(
      {super.key, required this.userName, required this.profileURL});

  final String userName;
  final String profileURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kSP30x),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kSP40x),
              child: CachedNetworkImage(
                imageUrl: profileURL,
                placeholder: (context, url) => const Center(
                  child: Icon(Icons.person),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(kSP20x),
          Text(
            userName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: kFontSize16x,
                color: kComponentColor,
                fontFamily: "Raleway"),
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
