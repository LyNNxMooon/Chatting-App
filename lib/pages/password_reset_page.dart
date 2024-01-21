import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/pages/auth_page.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/widgets/button_widget.dart';
import 'package:chatting_app/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PasswordResetPage extends StatefulWidget {
  PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _emailController = TextEditingController();

  Future sendPasswordResetLink() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(kSuccessfulPasswordLinkSentText),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.navigateWithReplacement(AuthPage()),
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSP25x),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kPasswordResetTitleText,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: kFontSize18x,
                    fontFamily: "Raleway"),
                textAlign: TextAlign.center,
              ),
              const Gap(kSP30x),
              TextFieldWidget(
                isObscureText: false,
                hintText: 'Email',
                controller: _emailController,
              ),
              const Gap(kSP20x),
              ButtonWidget(
                onTap: sendPasswordResetLink,
                text: "Send",
              )
            ],
          ),
        ),
      ),
    ));
  }
}
