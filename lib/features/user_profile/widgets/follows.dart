import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CountUserFollows extends StatelessWidget {
  final String type;
  final String userID;
  final bool otherUser;

  CountUserFollows({
    Key? key,
    required this.type,
    required this.userID,
    required this.otherUser ,
  }) : super(key: key);

  final DocumentReference docRef = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: otherUser
          ? FirebaseFirestore.instance
              .collection("users")
              .doc(userID)
              .collection(type)
              .snapshots()
          : docRef.collection(type).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final int documentCount = snapshot.data!.size;
          return Text(
            '$documentCount',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
