import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

FirebaseStorage storage = FirebaseStorage.instance;

class UserProfilePicture extends StatefulWidget {
  const UserProfilePicture({super.key});

  @override
  State<UserProfilePicture> createState() => _UserProfilePictureState();
}

class _UserProfilePictureState extends State<UserProfilePicture> {
  String? userPhotoUrl;
  String defaultUrl =
      "https://firebasestorage.googleapis.com/v0/b/sayit-dc5dc.appspot.com/o/profile_pictures%2Fdefault_profile_picture.png?alt=media&token=19d39e64-0864-4adb-b25e-a013e3479000";

  @override
  void initState() {
    super.initState();
    getUserProfileImage();
  }

  getUserProfileImage() {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    Reference imageRef =
        storage.ref("profile_pictures").child("$currentUserID.png");
    imageRef.getDownloadURL().then((downloadedUrl) {
      setState(() {
        userPhotoUrl = downloadedUrl.toString();
      });
    }).catchError((e) {
      //print("erreur ${e.error}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Image get from Storage")),
      body: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: userPhotoUrl == null
            ? NetworkImage(defaultUrl)
            : NetworkImage(userPhotoUrl!),
      ),
    );
  }
}
