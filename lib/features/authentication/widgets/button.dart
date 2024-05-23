import 'package:flutter/material.dart';
import 'package:sayit/constants/assets.dart';
import 'package:sayit/constants/button_style.dart';
import 'package:sayit/constants/text_style.dart';

// ignore: use_function_type_syntax_for_parameters
Widget signInButton(void onPressedFunction()) {
  return OutlinedButton(
    style: MyButtonStyle.signInUpOut(bgColor: Colors.black),
    onPressed: () {
      onPressedFunction();
    },
    child: Text(
      "Sign In",
      style: MyTextStyle.signInUpStyle(),
    ),
  );
}

// ignore: use_function_type_syntax_for_parameters
Widget signUpButton(void onPressedFunction()) {
  return OutlinedButton(
    style: MyButtonStyle.signInUpOut(bgColor: Colors.black),
    onPressed: () {
      onPressedFunction();
    },
    child: Text('Create account', style: MyTextStyle.signInUpStyle()),
  );
}

// ignore: use_function_type_syntax_for_parameters
Widget googleButton(void onPressedFunction()) {
  return OutlinedButton(
    style: MyButtonStyle.signInUpOut(),
    onPressed: () {
      onPressedFunction();
    },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            LogosAssets.googleLogo,
            height: 35.0,
          ),
          const SizedBox(width: 10),
          const Text(
            'Continue with Google',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

// ignore: use_function_type_syntax_for_parameters
Widget facebookButton(void onPressedFunction()) {
  return OutlinedButton(
    style: MyButtonStyle.signInUpOut(),
    onPressed: () {
      onPressedFunction();
    },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            LogosAssets.facebookLogo,
            height: 35.0,
          ),
          const SizedBox(width: 10),
          const Text(
            'Continue with Facebook',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
