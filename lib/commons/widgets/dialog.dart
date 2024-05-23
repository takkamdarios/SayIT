import 'package:flutter/material.dart';

class ShowDialog {
  static void alertDialog(BuildContext context,
      {required String alertTitle,
      required String message,
      Color color = Colors.lightBlue}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          alertTitle,
          style: TextStyle(color: color),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  static void error(BuildContext context, String errorMessage) {
    alertDialog(context,
        alertTitle: "Error", message: errorMessage, color: Colors.red);
  }

  static void succes(BuildContext context, String successMessage) {
    alertDialog(context, alertTitle: "Succes", message: successMessage);
  }

  static bool? pickImageFromGallery(BuildContext context) {
    bool? fromGallery;
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Choose image from:"),
        children: [
          SimpleDialogOption(
            onPressed: () => fromGallery = true,
            child: const Text("Gallery"),
          ),
          SimpleDialogOption(
            onPressed: () => fromGallery = false,
            child: const Text("Camera"),
          ),
        ],
      ),
    );

    return fromGallery;
  }
}
