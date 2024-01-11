import 'package:chatting_app/bloc/home_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kSecondaryColor,
          title: Text(
            "Home Page",
            style: TextStyle(color: kComponentColor),
          ),
          centerTitle: true,
          actions: [
            Builder(builder: (buttonContext) {
              final bloc = buttonContext.read<HomePageBloc>();
              return GestureDetector(
                onTap: () {
                  bloc.singOut();
                },
                child: Icon(
                  Icons.logout,
                  color: kComponentColor,
                ),
              );
            }),
          ],
        ),
        body: Center(),
      )),
    );
  }
}
