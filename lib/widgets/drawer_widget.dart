import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatting_app/bloc/profile_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/data/model/chatting_app_hive_model.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/pages/auth_page.dart';
import 'package:chatting_app/utils/enums.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/widgets/error_widget.dart';
import 'package:chatting_app/widgets/loading_state_widget.dart';
import 'package:chatting_app/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

final ChattingAppHiveModel _chattingAppHiveModel = ChattingAppHiveModel();

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfilePageBloc>(
      create: (context) => ProfilePageBloc(),
      child: Drawer(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Selector<ProfilePageBloc, LoadingState>(
          selector: (_, bloc) => bloc.getLoadingState,
          builder: (_, loadingState, __) => LoadingStateWidget(
              loadingState: loadingState,
              loadingSuccessWidget: DrawerItemsView(),
              errorWidget: DrawerErrorWidget()),
        ),
      ),
    );
  }
}

class DrawerItemsView extends StatelessWidget {
  const DrawerItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfilePageBloc>();
    return Selector<ProfilePageBloc, UserVO?>(
      builder: (_, user, __) => ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: BoxDecoration(color: kSecondaryColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile",
                style: TextStyle(
                    fontSize: kFontSize30x, fontWeight: FontWeight.bold),
              ),
              Gap(kSP15x),
              Container(
                width: kProfilePageAvatarSquareLength,
                height: kProfilePageAvatarSquareLength,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSP40x),
                    color: kAvatarColor),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kSP40x),
                  child: CachedNetworkImage(
                    imageUrl: user?.profileURL ?? '',
                    placeholder: (context, url) => const LoadingWidget(),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
        Gap(kSP20x),
        ListTile(
          leading: Icon(CupertinoIcons.person),
          title: Text(
            user?.name ?? '',
            style:
                TextStyle(fontSize: kFontSize16x, fontWeight: FontWeight.bold),
          ),
        ),
        Gap(kSP20x),
        ListTile(
          leading: Icon(CupertinoIcons.mail),
          title: Text(
            user?.email ?? '',
            style:
                TextStyle(fontSize: kFontSize16x, fontWeight: FontWeight.bold),
          ),
        ),
        Gap(MediaQuery.of(context).size.height * 0.4),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            "Logout",
            style:
                TextStyle(fontSize: kFontSize16x, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            _chattingAppHiveModel.removeCurrentUserVO();
            bloc.singOut();
            context.navigateWithReplacement(AuthPage());
          },
        ),
      ]),
      selector: (_, bloc) => bloc.getUser,
    );
  }
}

class DrawerErrorWidget extends StatelessWidget {
  const DrawerErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ProfilePageBloc, String?>(
      builder: (_, error, __) => ShowErrorWidget(errorMessage: error ?? ''),
      selector: (_, bloc) => bloc.getErrorMessage,
    );
  }
}
