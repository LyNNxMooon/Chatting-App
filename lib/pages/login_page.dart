import 'package:chatting_app/bloc/login_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/pages/register_page.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/widgets/button_widget.dart';
import 'package:chatting_app/widgets/loading_widget.dart';
import 'package:chatting_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageBloc>(
      create: (context) => LoginPageBloc(),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
                  Text(
                    kLoginTitle,
                    style: TextStyle(
                        fontSize: kFontSize20x,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
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
                  Builder(builder: (buttonContext) {
                    final bloc = buttonContext.read<LoginPageBloc>();
                    return ButtonWidget(
                      onTap: () async {
                        try {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const LoadingWidget());
                          bloc.setUserEmail = _emailController.text;
                          bloc.setUserPassword = _passwordController.text;
                          await bloc
                              .signInWithEmailAndPassword()
                              .then((value) => context.navigateBack());
                        } catch (e) {
                          context.navigateBack();
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
                      Text(
                        kRegisterNavigationText,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      const Gap(kSP10x),
                      GestureDetector(
                        onTap: () =>
                            context.navigateWithReplacement(RegisterPage()),
                        child: const Text(
                          "Register",
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
