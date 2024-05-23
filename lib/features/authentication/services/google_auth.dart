import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:sayit/commons/services/platform_check.dart';
import 'package:sayit/constants/helpers.dart';

const Color bgColor = Color(0xFF4285F4);

class GoogleAuth {
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("users");

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: bgColor,
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  static Future<void> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        await auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            GoogleAuth.customSnackBar(
              content: 'Le compte existe déjà avec un identifiant différent',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            GoogleAuth.customSnackBar(
                content:
                    "Une Erreur s'est produite lors de l'accès aux informations d'identification. Réssayer."),
          );
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          GoogleAuth.customSnackBar(
            content:
                "Une erreur s'est produite lors de l'utilisation de Google Sign-In. Réessayer",
          ),
        );
      }
    }
  }

  static Future<void> signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    ShowProgressIndicators.circular(context);
    await Future.delayed(const Duration(seconds: 1));
    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      //
    }
  }
}
