import 'package:flutter/material.dart';
import 'package:sayit/features/authentication/services/firebase_auth.dart';
import 'package:sayit/features/authentication/widgets/appbar.dart';
import 'package:sayit/features/authentication/widgets/button.dart';
import 'package:sayit/commons/widgets/dialog.dart';
import 'package:sayit/features/authentication/widgets/signup_sections.dart';
import 'package:sayit/features/authentication/widgets/text_field.dart';
import 'package:sayit/responsive.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final fullnameController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: signInUpAppBar,
        body: Responsive(
            mobile: MobileSignUpView(
                fullnameController: fullnameController,
                usernameController: usernameController,
                emailController: emailController,
                passwordController: passwordController,
                passwordConfirmationController: passwordConfirmationController),
            desktop: DesktopSignUpView(
                fullnameController: fullnameController,
                usernameController: usernameController,
                emailController: emailController,
                passwordController: passwordController,
                passwordConfirmationController:
                    passwordConfirmationController)));
  }
}

class MobileSignUpView extends StatelessWidget {
  const MobileSignUpView({
    super.key,
    required this.fullnameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
  });

  final TextEditingController fullnameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            titleSection(title: "Create your new account"),
            const SizedBox(height: 50),
            textFormField("Fullname", fullnameController),
            textFormField("Username", usernameController),
            textFormField("Email address", emailController),
            PasswordFormField(
              labelText: "Password",
              fieldController: passwordController,
            ),
            PasswordFormField(
              labelText: "Confirm Password",
              fieldController: passwordConfirmationController,
            ),
            const SizedBox(height: 50),
            signUpButton(() {
              if (passwordController.text.trim() !=
                  passwordConfirmationController.text.trim()) {
                ShowDialog.error(context, "Both passwords are different !");
              } else {
                UserFirebaseController().signUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    fullname: fullnameController.text.trim(),
                    username: usernameController.text.trim(),
                    context: context,
                    errorMessage: "Erreur");
              }
            }),
          ],
        ),
      ),
    );
  }
}

class DesktopSignUpView extends StatelessWidget {
  const DesktopSignUpView({
    super.key,
    required this.fullnameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
  });

  final TextEditingController fullnameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(child: Container()),
            SizedBox(
              width: 600,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  titleSection(title: "Create your new account"),
                  const SizedBox(height: 50),
                  textFormField("Fullname", fullnameController),
                  textFormField("Username", usernameController),
                  textFormField("Email address", emailController),
                  PasswordFormField(
                    labelText: "Password",
                    fieldController: passwordController,
                  ),
                  PasswordFormField(
                    labelText: "Confirm Password",
                    fieldController: passwordConfirmationController,
                  ),
                  const SizedBox(height: 50),
                  signUpButton(() {
                    if (passwordController.text.trim() !=
                        passwordConfirmationController.text.trim()) {
                      ShowDialog.error(
                          context, "Both passwords are different !");
                    } else {
                      UserFirebaseController().signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          fullname: fullnameController.text.trim(),
                          username: usernameController.text.trim(),
                          context: context,
                          errorMessage: "Erreur");
                    }
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
