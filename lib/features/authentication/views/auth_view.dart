import 'package:flutter/material.dart';
//import 'package:sayit/commons/services/platform_check.dart';
import 'package:sayit/constants/helpers.dart';
import 'package:sayit/features/authentication/views/signin_view.dart';
import 'package:sayit/features/authentication/views/signup_view.dart';
import 'package:sayit/features/authentication/widgets/button.dart';
import 'package:sayit/features/authentication/widgets/divider.dart';
import 'package:sayit/features/authentication/widgets/google_button.dart';
import 'package:sayit/features/authentication/widgets/signup_sections.dart';
import 'package:sayit/features/authentication/widgets/webauthwidgets.dart';
import 'package:sayit/responsive.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return const Scaffold(
            body: Responsive(
              mobile: MobileAuthView(),
              desktop: DesktopWebAuthView(),
            ),
          );
        },
      ),
    );
  }
}

class MobileAuthView extends StatelessWidget {
  const MobileAuthView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              logoSection,
              const SizedBox(height: 80),
              titleSection(),
              const SizedBox(height: 100),
              const GoogleButton(),
              divider,
              const SizedBox(height: 10),
              signUpButton(() {
                Helpers.goto(context, SignUpView());
              }),
              const SizedBox(height: 25),
              privacySection,
              const SizedBox(height: 15),
              signinSection(() {
                Helpers.goto(
                    context,
                    SignInView(
                      title: "Sign in with your account",
                    ));
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopWebAuthView extends StatelessWidget {
  const DesktopWebAuthView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: Center(
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(child: Container()),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                decoration: boxDecoration,
                height: 700,
                width: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    logoSection,
                    const SizedBox(height: 80),
                    titleSection(),
                    const SizedBox(height: 100),
                    const GoogleButton(),
                    divider,
                    const SizedBox(height: 10),
                    signUpButton(() {
                      Helpers.goto(context, SignUpView());
                    }),
                    const SizedBox(height: 25),
                    privacySection,
                    const SizedBox(height: 15),
                    signinSection(() {
                      Helpers.goto(context,
                          SignInView(title: "Sign in with your account"));
                    })
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
