import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextStyle {
  static TextStyle titleStyle = GoogleFonts.roboto(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static TextStyle signInUpStyle({Color textColor = Colors.white}) {
    return GoogleFonts.roboto(
      color: textColor,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );
  }

  
}
