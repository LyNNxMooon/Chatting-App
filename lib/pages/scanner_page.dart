// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';

import 'package:scan/scan.dart';

class ScannerPage extends StatelessWidget {
  ScannerPage({super.key});
  ScanController controller = ScanController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
            onTap: () {
              context.navigateBack();
            },
            child: Icon(
              Icons.arrow_back,
              color: kComponentColor,
            )),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.6,
          child: ScanView(
            controller: controller,
            scanAreaScale: .7,
            scanLineColor: kSecondaryColor,
            onCapture: (data) {
              try {
                final rawData = jsonDecode(data);
                final user = UserVO.fromJson(rawData);
                showDialog(
                  context: context,
                  builder: (_) {
                    return DialogWidget(
                      user: user,
                    );
                  },
                );
              } catch (error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error.toString())));
              }
            },
          ),
        ),
      ),
    ));
  }
}
