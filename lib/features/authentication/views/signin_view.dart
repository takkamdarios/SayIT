import 'package:flutter/material.dart';
import 'package:sayit/features/authentication/services/firebase_auth.dart';
import 'package:sayit/features/authentication/widgets/appbar.dart';
import 'package:sayit/features/authentication/widgets/button.dart';
import 'package:sayit/features/authentication/widgets/signup_sections.dart';
import 'package:sayit/features/authentication/widgets/text_field.dart';
import 'package:sayit/responsive.dart';

class SignInView extends StatelessWidget {
  final String title;
  SignInView({super.key, required this.title});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: signInUpAppBar,
            body: Responsive(
              mobile: MobileSignInView(
                  title: title,
                  emailController: emailController,
                  passwordController: passwordController),
              desktop: DesktopSignInView(
                  title: title,
                  emailController: emailController,
                  passwordController: passwordController),
            ));
      },
    );
  }
}

class DesktopSignInView extends StatelessWidget {
  const DesktopSignInView({
    super.key,
    required this.title,
    required this.emailController,
    required this.passwordController,
  });

  final String title;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(child: Container()),
            SizedBox(
              width: 600,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  titleSection(title: title),
                  const SizedBox(height: 100),
                  textFormField("Email address", emailController),
                  PasswordFormField(
                      labelText: "Password",
                      fieldController: passwordController),
                  const SizedBox(height: 50),
                  signInButton(() {
                    UserFirebaseController().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        context: context);
                  }),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

class MobileSignInView extends StatelessWidget {
  const MobileSignInView({
    super.key,
    required this.title,
    required this.emailController,
    required this.passwordController,
  });

  final String title;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            titleSection(title: title),
            const SizedBox(height: 100),
            textFormField("Email address", emailController),
            PasswordFormField(
                labelText: "Password", fieldController: passwordController),
            const SizedBox(height: 50),
            signInButton(() {
              UserFirebaseController().signIn(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  context: context);
            }),
          ],
        ),
      ),
    );
  }
}
