import 'package:flutter/material.dart';

class MyTextFeilds extends StatelessWidget {
  const MyTextFeilds({super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText});

  final controller;
  final String? hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
