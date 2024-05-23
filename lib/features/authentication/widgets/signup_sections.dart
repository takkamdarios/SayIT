import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sayit/constants/assets.dart';
import 'package:sayit/constants/text_style.dart';

Widget logoSection = SizedBox(
  width: 150,
  height: 150,
  child: Image.asset(LogosAssets.sayitLogo),
);

Widget titleSection({String title = "Speech, with trust"}) {
  return Row(
    children: [
      Expanded(
        child: Center(
          child: Text(
            title,
            style: MyTextStyle.titleStyle,
          ),
        ),
      )
    ],
  );
}

Widget privacySection = RichText(
  text: TextSpan(
    children: [
      const TextSpan(
        text: "By signing up, you agree to our ",
        style: TextStyle(color: Colors.black),
      ),
      TextSpan(
        text: "Terms, ",
        style: const TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()..onTap = () {},
      ),
      TextSpan(
        text: "Privacy Policy, ",
        recognizer: TapGestureRecognizer()..onTap = () {},
        style: const TextStyle(color: Colors.blue),
      ),
      const TextSpan(
        text: "and ",
        style: TextStyle(color: Colors.black),
      ),
      TextSpan(
        text: "Cookie Use.",
        recognizer: TapGestureRecognizer()..onTap = () {},
        style: const TextStyle(color: Colors.blue),
      ),
    ],
  ),
);

// ignore: use_function_type_syntax_for_parameters
Widget signinSection(void onTapFunction()) {
  return Center(
    child: RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "Have an account already? ",
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: " Sign in",
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTapFunction();
              },
          ),
        ],
      ),
    ),
  );
}
