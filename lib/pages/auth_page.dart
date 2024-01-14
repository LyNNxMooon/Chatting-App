import 'package:chatting_app/pages/login_page.dart';
import 'package:chatting_app/pages/navigator_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const NavigatorPage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
