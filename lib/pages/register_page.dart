import 'package:chatting_app/bloc/register_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/pages/auth_page.dart';

import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/widgets/button_widget.dart';
import 'package:chatting_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterPageBloc>(
      create: (context) => RegisterPageBloc(),
      child: SafeArea(
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
                    color: kSecondaryColor,
                    size: kSP100x,
                  ),
                  const Gap(kSP20x),
                  const Text(
                    kRegisterTitle,
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
                  const Gap(kSP10x),
                  TextFieldWidget(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      isObscureText: true),
                  const Gap(kSP15x),
                  Builder(builder: (buttonContext) {
                    final bloc = buttonContext.read<RegisterPageBloc>();
                    return ButtonWidget(
                      onTap: () async {
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          ScaffoldMessenger.of(buttonContext).showSnackBar(
                              SnackBar(
                                  content: Text("Passwords do not match")));
                          return;
                        }
                        try {
                          bloc.setUserEmail = _emailController.text;
                          bloc.setUserPassword = _passwordController.text;
                          await bloc.singUpUser();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuthPage(),
                              ));
                        } catch (e) {
                          ScaffoldMessenger.of(buttonContext).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      },
                      text: "Log In",
                    );
                  }),
                  const Gap(kSP20x),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(kLoginNavigationText),
                      const Gap(kSP10x),
                      GestureDetector(
                        onTap: () => context.navigateBack(),
                        child: const Text(
                          "LogIn",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kSecondaryColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
