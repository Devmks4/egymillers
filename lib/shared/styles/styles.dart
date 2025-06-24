import 'package:flutter/material.dart';
import 'colors.dart';

InputDecoration textFieldDecoration ({
  required String labelText,
  required Icon prefixIcon ,
}) {
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
        color: primaryColor,
    ),
      ),
    labelText: labelText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    prefixIcon: prefixIcon,
  );
}

TextStyle listTextStyle () {
  return TextStyle(
    fontWeight: FontWeight.bold,
  );
}