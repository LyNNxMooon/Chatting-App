import 'package:chatting_app/bloc/home_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/pages/chat_page.dart';
import 'package:chatting_app/utils/enums.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/widgets/error_widget.dart';
import 'package:chatting_app/widgets/loading_state_widget.dart';

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
            ),
          ),
          toolbarHeight: kSP70x,
          actions: [
            Builder(builder: (buttonContext) {
              final bloc = buttonContext.read<HomePageBloc>();
              return GestureDetector(
                onTap: () {
                  bloc.singOut();
                },
                child: Icon(
                  Icons.logout,
                  color: kComponentColor,
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
        padding:
            const EdgeInsets.symmetric(horizontal: kSP20x, vertical: kSP40x),
        child: ListView.separated(
            itemBuilder: (_, index) => GestureDetector(
                  onTap: () => context.navigateToNext(ChatPage(
                      userEmail: userList![index].email,
                      userID: userList[index].uid)),
                  child: Text(
                    userList?[index].email ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: kFontSize18x),
                  ),
                ),
            separatorBuilder: (_, index) => const Gap(kSP70x),
            itemCount: userList?.length ?? 0),
      ),
      selector: (_, bloc) => bloc.getUserList,
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
