import 'package:flutter/material.dart';

AppBar profileAppBar({Color? bgColor = Colors.white}) {
  return AppBar(
    foregroundColor: Colors.black,
    //leading: Icon(Icons.arrow_back),
    centerTitle: true,
    backgroundColor: bgColor,
    elevation: 0,
  );
}
