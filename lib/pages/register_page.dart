import 'dart:io';

import 'package:chatting_app/bloc/register_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/pages/navigator_page.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/utils/file_picker_utils.dart';
import 'package:chatting_app/widgets/button_widget.dart';
import 'package:chatting_app/widgets/loading_widget.dart';
import 'package:chatting_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _nameController = TextEditingController();
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
                  ProfilePhotoView(),
                  const Gap(kSP20x),
                  const Text(
                    kRegisterTitle,
                    style: TextStyle(
                        fontSize: kFontSize20x, fontWeight: FontWeight.bold),
                  ),
                  const Gap(kSP30x),
                  TextFieldWidget(
                      controller: _nameController,
                      hintText: "Name",
                      isObscureText: false),
                  const Gap(kSP10x),
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
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const LoadingWidget());
                          bloc.setUserEmail = _emailController.text;
                          bloc.setUserPassword = _passwordController.text;
                          bloc.setUserName = _nameController.text;
                          await bloc.singUpUser().then((value) {
                            context.navigateBack();
                            context.navigateWithReplacement(NavigatorPage());
                          });
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

class ProfileAvatarView extends StatelessWidget {
  const ProfileAvatarView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterPageBloc>();
    return GestureDetector(
      onTap: () async {
        final image = await FilePickerUtils.getImage();
        bloc.setPickedFile = image;
      },
      child: Container(
        width: kRegisterProfileAvatarSquareLength,
        height: kRegisterProfileAvatarSquareLength,
        decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(kSP50x)),
        child: Center(
          child: Icon(
            Icons.add_a_photo,
            color: kPrimaryColor,
            size: kSP70x,
          ),
        ),
      ),
    );
  }
}

class ProfilePhotoView extends StatelessWidget {
  const ProfilePhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<RegisterPageBloc, File?>(
      builder: (_, file, __) => Container(
        width: kRegisterProfileAvatarSquareLength,
        height: kRegisterProfileAvatarSquareLength,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(kSP50x)),
        child: file != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(kSP50x),
                child: Positioned.fill(
                    child: Image.file(
                  File(
                    file.path,
                  ),
                  fit: BoxFit.cover,
                )))
            : const ProfileAvatarView(),
      ),
      selector: (_, bloc) => bloc.getPickedFile,
    );
  }
}
