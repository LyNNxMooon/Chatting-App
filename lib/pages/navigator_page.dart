import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/pages/chat_list_page.dart';
import 'package:chatting_app/pages/home_page.dart';
import 'package:chatting_app/pages/qr_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  List<Widget> buildScreens() {
    return [const ChatListPage(), const HomePage(), const QRPage()];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chat_bubble),
        title: ("Chats"),
        activeColorPrimary: kSecondaryColor,
        inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_2),
        title: ("Contacts"),
        activeColorPrimary: kSecondaryColor,
        inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.qrcode),
        title: ("QR"),
        activeColorPrimary: kSecondaryColor,
        inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
      )
    ];
  }

  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarItems(),
      confineInSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
      //hideNavigationBar: true,
    );
  }
}
