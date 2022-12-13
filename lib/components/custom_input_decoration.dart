import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration onCustomInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.only(left: 10),
    );
  }
}
