import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.onTap, required this.text});

  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(kSP20x),
        decoration: const BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(kSP10x))),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: kComponentColor,
                fontWeight: FontWeight.bold,
                fontFamily: "Raleway"),
          ),
        ),
      ),
    );
  }
}
