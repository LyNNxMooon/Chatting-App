import 'package:chatting_app/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
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
      style: TextStyle(color: kComponentColor),
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          )),
          fillColor: kTextFieldsFillColor,
          filled: true,
          hintStyle: const TextStyle(color: kComponentColor)),
    );
  }
}
