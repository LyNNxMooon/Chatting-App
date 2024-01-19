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
      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
          )),
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary)),
    );
  }
}
