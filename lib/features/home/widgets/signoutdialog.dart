import 'package:flutter/material.dart';
import 'package:sayit/features/authentication/services/google_auth.dart';

class HomeDialog {
  static void signOutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Confirmation",
          style: TextStyle(color: Colors.red[200]),
        ),
        content: const Text("Do you really want to sign out ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("NO"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              GoogleAuth.signOut(context);
            },
            child: const Text("YES"),
          ),
        ],
      ),
    );
  }
}
