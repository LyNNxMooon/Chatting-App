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
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kComponentColor)),
          fillColor: kTextFieldsFillColor,
          filled: true,
          hintStyle: const TextStyle(color: kComponentColor)),
    );
  }
}
