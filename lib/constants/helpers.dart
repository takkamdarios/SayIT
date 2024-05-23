import 'package:flutter/material.dart';

class Helpers {
  static void goto(BuildContext context, Widget screen,
      {bool isReplaced = false}) {
    isReplaced
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => screen),
          )
        : Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screen),
          );
  }
}

class ShowProgressIndicators {
  static void circular(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
  }
}


