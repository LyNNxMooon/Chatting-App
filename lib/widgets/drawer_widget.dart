import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatting_app/bloc/profile_page_bloc.dart';
import 'package:chatting_app/bloc/theme_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/data/model/chatting_app_hive_model.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/pages/auth_page.dart';
import 'package:chatting_app/theme/light_theme.dart';
import 'package:chatting_app/utils/enums.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/widgets/error_widget.dart';
import 'package:chatting_app/widgets/loading_state_widget.dart';
import 'package:chatting_app/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

final ChattingAppHiveModel _chattingAppHiveModel = ChattingAppHiveModel();

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfilePageBloc>(
      create: (context) => ProfilePageBloc(),
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
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

class DrawerItemsView extends StatefulWidget {
  const DrawerItemsView({super.key});

  @override
  State<DrawerItemsView> createState() => _DrawerItemsViewState();
}

class _DrawerItemsViewState extends State<DrawerItemsView> {
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
                    fontSize: kFontSize30x,
                    fontWeight: FontWeight.bold,
                    color: kComponentColor),
              ),
              Gap(kSP15x),
              GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (_) =>
                      ChangeAvatarDialog(profile: user?.profileURL ?? ''),
                ),
                child: Container(
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
                ),
              )
            ],
          ),
        ),
        Gap(kSP20x),
        ListTile(
          leading: Icon(
            CupertinoIcons.person,
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            user?.name ?? '',
            style: TextStyle(
              fontSize: kFontSize16x,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        Gap(kSP20x),
        ListTile(
          leading: Icon(
            CupertinoIcons.mail,
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            user?.email ?? '',
            style: TextStyle(
              fontSize: kFontSize16x,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        Gap(kSP30x),
        Padding(
          padding: const EdgeInsets.only(
            left: kSP15x,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Builder(builder: (_) {
                final bloc = context.read<ThemeBloc>();
                return FlutterSwitch(
                  inactiveText: "Light",
                  activeTextColor: kComponentColor,
                  activeColor: Colors.blueGrey,
                  activeText: "Dark",
                  width: 100.0,
                  height: 40.0,
                  valueFontSize: 15.0,
                  toggleSize: 45.0,
                  value: bloc.themeData == lightTheme ? false : true,
                  borderRadius: 30.0,
                  showOnOff: true,
                  onToggle: (_) {
                    bloc.toggleTheme();
                  },
                );
              }),
            ],
          ),
        ),
        Gap(MediaQuery.of(context).size.height * 0.31),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            "Logout",
            style: TextStyle(
              fontSize: kFontSize16x,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          onTap: () {
            _chattingAppHiveModel.removeCurrentUserVO();
            bloc.singOut();
            context.navigateBack();
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

class ChangeAvatarDialog extends StatelessWidget {
  const ChangeAvatarDialog({super.key, required this.profile});

  final String profile;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kPrimaryColor,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            kChangeAvatarText,
            style: TextStyle(
                color: kComponentColor,
                fontSize: kFontSize16x,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: kSP20x),
            width: kProfilePageAvatarSquareLength,
            height: kProfilePageAvatarSquareLength,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(kSP40x)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kSP40x),
              child: CachedNetworkImage(
                imageUrl: profile,
                placeholder: (context, url) => const LoadingWidget(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Update'),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(kSecondaryColor)),
          )
        ],
      ),
    );
  }
}
