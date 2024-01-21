import 'package:chatting_app/constants/dimension.dart';
import 'package:flutter/material.dart';

class MessageInputField extends StatelessWidget {
  const MessageInputField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.isObscureText});

  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscureText,
      style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: "Raleway"),
      cursorRadius: Radius.circular(kSP25x),
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kSP25x),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kSP25x),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              )),
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: "Raleway")),
    );
  }
}
