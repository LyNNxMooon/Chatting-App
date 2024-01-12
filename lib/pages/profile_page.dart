import 'package:chatting_app/bloc/profile_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/pages/auth_page.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfilePageBloc>(
      create: (context) => ProfilePageBloc(),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Builder(builder: (buttonContext) {
            final bloc = buttonContext.read<ProfilePageBloc>();
            return ElevatedButton(
                onPressed: () {
                  bloc.singOut();
                  context.navigateWithReplacement(AuthPage());
                },
                child: Text("Sign Out"));
          }),
        ),
      )),
    );
  }
}
