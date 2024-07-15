// ignore_for_file: prefer_const_constructors, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.obscureText,
      this.errorText});
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            hintText: errorText == null ? hintText : errorText,
            hintStyle: errorText == null
                ? GoogleFonts.poppins()
                : GoogleFonts.poppins(fontSize: 14, color: Colors.red),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          )),
    );
  }
}
