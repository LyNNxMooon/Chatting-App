import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/widgets/button_widget.dart';
import 'package:chatting_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSP20x),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.message,
                  color: kComponentColor,
                  size: kSP100x,
                ),
                const Gap(kSP20x),
                const Text(
                  kLoginTitle,
                  style: TextStyle(
                      fontSize: kFontSize20x, fontWeight: FontWeight.bold),
                ),
                const Gap(kSP30x),
                TextFieldWidget(
                    controller: _emailController,
                    hintText: "Email",
                    isObscureText: false),
                const Gap(kSP10x),
                TextFieldWidget(
                    controller: _passwordController,
                    hintText: "Password",
                    isObscureText: true),
                const Gap(kSP15x),
                ButtonWidget(
                  text: "Log In",
                  onTap: () {},
                ),
                const Gap(kSP20x),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(kRegisterNavigationText),
                    const Gap(kSP10x),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Register",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
