import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayit/commons/services/platform_check.dart';
import 'package:sayit/commons/widgets/appbar.dart';
import 'package:sayit/features/sits/widgets/sits.dart';
import 'package:sayit/features/sits/services/create_sit.dart';

FirebaseStorage storage = FirebaseStorage.instance;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? userFullname;
  String? username;
  String? pictureurl;
  String selectedFile = "";
  final picker = ImagePicker();
  Uint8List? selectedImageInBytes;
  String? userPhotoUrl;
  String? userID;

  @override
  void initState() {
    super.initState();
    getUserProfileData();
  }

  getUserProfileData() {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .get()
        .then((doc) {
      if (doc.exists) {
        setState(() {
          userID = currentUserID;
          userFullname = doc.get("fullname");
          username = doc.get("username");
          pictureurl = doc.get("pictureurl");
        });
      }
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context, builder: (context) => const CreateSit()),
        child: const Icon(Icons.add),
      ),
      appBar:
          Plateforme.isMobile() ? mobileAppBar(context, pictureurl) : webAppBar,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sits')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final sitDocs = snapshot.data!.docs;

          if (sitDocs.isEmpty) {
            return const Center(
              child: Text('No sits available.'),
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: sitDocs.length,
            itemBuilder: (context, index) {
              final sitData = sitDocs[index].data() as Map<String, dynamic>;
              final sitID = sitDocs[index].id;
              final sitUserID = sitData["userID"];

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(sitUserID)
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasError) {
                    return Text('Error: ${userSnapshot.error}');
                  }

                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  final userfullname = userData['fullname'];
                  final username = userData['username'];
                  final pictureurl = userData['pictureurl'];

                  return SitCard(
                    sitID: sitID,
                    currentUserID: FirebaseAuth.instance.currentUser!.uid,
                    userfullname: userfullname,
                    username: username,
                    sitContent: sitData["content"],
                    pictureurl: pictureurl,
                    sitUserID: sitUserID,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
