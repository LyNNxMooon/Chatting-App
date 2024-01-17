import 'dart:convert';

import 'package:chatting_app/bloc/qr__page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/data/model/chatting_app_hive_model.dart';
import 'package:chatting_app/pages/scanner_page.dart';
import 'package:chatting_app/utils/enums.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/widgets/drawer_widget.dart';
import 'package:chatting_app/widgets/error_widget.dart';
import 'package:chatting_app/widgets/loading_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

final ChattingAppHiveModel _chattingAppHiveModel = ChattingAppHiveModel();

class QRPage extends StatelessWidget {
  const QRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QRPageBloc>(
      create: (context) => QRPageBloc(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButton: Selector<QRPageBloc, LoadingState>(
              selector: (_, bloc) => bloc.getLoadingState,
              builder: (_, loadingState, __) =>
                  loadingState == LoadingState.complete
                      ? FloatingActionButtonView(baseContext: context)
                      : const SizedBox()),
          drawer: DrawerWidget(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 1,
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              "QR",
              style: TextStyle(
                  color: kAppBarComponentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: kFontSize24x),
            ),
            toolbarHeight: kSP70x,
            actions: [
              Builder(builder: (buttonContext) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(buttonContext).openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: kSP10x),
                    child: Icon(
                      Icons.menu_outlined,
                      color: kAppBarComponentColor,
                    ),
                  ),
                );
              }),
            ],
          ),
          body: Selector<QRPageBloc, LoadingState>(
              selector: (_, bloc) => bloc.getLoadingState,
              builder: (_, loadingState, __) => LoadingStateWidget(
                  loadingState: loadingState,
                  loadingSuccessWidget: const QRPageItemView(),
                  errorWidget: const QRPageErrorStateItemView())),
        ),
      ),
    );
  }
}

class QRPageItemView extends StatelessWidget {
  const QRPageItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: QrImageView(
      backgroundColor: kPrimaryColor,
      data: jsonEncode(_chattingAppHiveModel.getCurrentUserVO),
      version: QrVersions.auto,
      size: kQRCodeSquareLength,
    ));
  }
}

class QRPageErrorStateItemView extends StatelessWidget {
  const QRPageErrorStateItemView();

  @override
  Widget build(BuildContext context) {
    return Selector<QRPageBloc, String?>(
        selector: (_, bloc) => bloc.getErrorMessage,
        builder: (_, errorMessage, __) =>
            ShowErrorWidget(errorMessage: errorMessage ?? ''));
  }
}

class FloatingActionButtonView extends StatelessWidget {
  const FloatingActionButtonView({super.key, required this.baseContext});

  final BuildContext baseContext;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kSecondaryColor,
      onPressed: () {
        baseContext.navigateToNext(ScannerPage());
      },
      child: Icon(Icons.qr_code_scanner, color: kComponentColor),
    );
  }
}
