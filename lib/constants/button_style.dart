import 'package:flutter/material.dart';

class MyButtonStyle {
  static ButtonStyle signInUpOut({Color bgColor = Colors.white}) {
    return OutlinedButton.styleFrom(
      backgroundColor: bgColor,
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }
}
