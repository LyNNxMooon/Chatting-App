import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chatting_app/bloc/theme_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/firebase_options.dart';
import 'package:chatting_app/pages/auth_page.dart';
import 'package:chatting_app/persistent/hive_constant.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(UserVOAdapter());
  await Hive.openBox<UserVO>(kHiveCurrentUserVOBox);
  await Hive.openBox<bool>(kHiveThemeTriggerBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: Selector<ThemeBloc, ThemeData>(
        builder: (_, theme, __) => MaterialApp(
          home: AnimatedSplashScreen(
              centered: true,
              duration: 2500,
              splashIconSize: double.infinity,
              splash: SplashScreenWidget(),
              nextScreen: const AuthPage(),
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: kPrimaryColor),
          debugShowCheckedModeBanner: false,
          theme: theme,
        ),
        selector: (_, bloc) => bloc.themeData,
      ),
    );
  }
}

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(MediaQuery.of(context).size.height * 0.33),
          const Icon(
            Icons.message,
            color: kSecondaryColor,
            size: kSP100x,
          ),
          Gap(MediaQuery.of(context).size.height * 0.35),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                kSplashScreenText,
                style: TextStyle(
                    fontSize: kFontSize16x,
                    fontWeight: FontWeight.bold,
                    color: kComponentColor,
                    fontFamily: "Raleway"),
              ),
              Gap(kSP5x),
              Text(
                "Chats",
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: kFontSize18x,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Raleway"),
              )
            ],
          )
        ],
      ),
    );
  }
}
