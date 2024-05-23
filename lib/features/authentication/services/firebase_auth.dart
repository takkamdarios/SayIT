//import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sayit/commons/widgets/bottombar.dart';
import 'package:sayit/constants/helpers.dart';
import 'package:sayit/commons/widgets/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("users");
  bool isLoading = false;

  void _errorDialog(BuildContext context, String errorMessage) async {
    await Future.delayed(const Duration(seconds: 1));
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    ShowDialog.error(context, errorMessage);
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      ShowProgressIndicators.circular(context);
      await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {const BottomBar()});
    } on FirebaseAuthException catch (e) {
      //print(e.code);
      switch (e.code) {
        case "user-not-found":
          _errorDialog(context, "No user found for that email.");
          break;

        case "wrong-password":
          _errorDialog(context, "Wrong password provided");
          break;

        default:
          _errorDialog(context, "Email address or password mismatched !");
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullname,
    required String username,
    required BuildContext context,
    required String errorMessage,
  }) async {
    String defaultUrl =
        "https://firebasestorage.googleapis.com/v0/b/sayit-dc5dc.appspot.com/o/profile_pictures%2Fdefault_profile_picture.png?alt=media&token=19d39e64-0864-4adb-b25e-a013e3479000";

    try {
      ShowProgressIndicators.circular(context);
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        addUser(value.user!.uid, fullname, username, defaultUrl,
            context: context, errorMessage: errorMessage);
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          _errorDialog(context, "Email address already in use.");
          break;

        case "invalid-email":
          _errorDialog(context, "Please use a valid email address");
          break;

        case "weak-password":
          _errorDialog(context, "Please use a strongest password");
          break;

        default:
          _errorDialog(context, "Please fill in empty fields ");
      }
    }
  }

  Future<void> signOut() async {
    //ShowProgressIndicators.circular(context);
    await _auth.signOut();
  }

  Future<void> addUser(
      String userID, String fullname, String username, String pictureurl,
      {BuildContext? context, String? errorMessage}) async {
    await userRef
        .doc(userID)
        .set({
          "fullname": fullname,
          "username": "@${username.toLowerCase()}",
          "pictureurl": pictureurl,
        })
        .catchError((error) => ShowDialog.error(context!, errorMessage!))
        .then((value) {
          userRef.doc(userID).collection("followers").add({"userID": ""});
          userRef.doc(userID).collection("following").add({"userID": ""});
        });
  }
}
