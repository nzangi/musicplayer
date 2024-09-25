import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  TextEditingController controller = TextEditingController();
  MyTextField({required this.hintText,required this.controller,super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText
      ).applyDefaults(Theme.of(context).inputDecorationTheme),

    );
  }
}
