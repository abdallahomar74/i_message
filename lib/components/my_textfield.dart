import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool obscure;
  const MyTextfield(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle( color: Colors.black),
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: const TextStyle( color: Colors.grey),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none)),
    );
  }
}
