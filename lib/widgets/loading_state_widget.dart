import 'package:chatting_app/utils/enums.dart';
import 'package:chatting_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget(
      {super.key,
      required this.loadingState,
      required this.loadingSuccessWidget,
      required this.errorWidget});

  final LoadingState loadingState;
  final Widget loadingSuccessWidget;

  final Widget errorWidget;

  @override
  Widget build(BuildContext context) {
    return switch (loadingState) {
      LoadingState.loading => const LoadingWidget(),
      LoadingState.error => errorWidget,
      _ => loadingSuccessWidget,
    };
  }
}
