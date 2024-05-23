import 'package:flutter/material.dart';
import 'package:sayit/constants/assets.dart';
import 'package:sayit/constants/button_style.dart';
import 'package:sayit/features/authentication/services/google_auth.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? const CircularProgressIndicator()
          : OutlinedButton(
              style: MyButtonStyle.signInUpOut(),
              onPressed: () async {
                setState(() => _isSigningIn = true);
                await GoogleAuth.signInWithGoogle(context: context);

                //setState(() {
                //_isSigningIn = false;
                //});
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
            ),
    );
  }
}
