import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  const Responsive({super.key, required this.mobile, required this.desktop});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 700;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 700;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 110 &&
      MediaQuery.of(context).size.width >= 650;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width < 700) {
      return mobile;
    } else {
      return desktop;
    }
  }
}
