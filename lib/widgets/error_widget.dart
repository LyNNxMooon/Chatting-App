import 'package:chatting_app/constants/dimension.dart';
import 'package:flutter/material.dart';

class ShowErrorWidget extends StatelessWidget {
  const ShowErrorWidget({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: kFontSize18x,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
