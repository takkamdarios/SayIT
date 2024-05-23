import 'package:flutter/material.dart';

BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 10,
        blurRadius: 20,
        offset: const Offset(0, 3),
      )
    ]);
