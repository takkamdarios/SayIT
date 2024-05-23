import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayit/commons/services/platform_check.dart';
import 'package:sayit/commons/widgets/dialog.dart';
import 'package:sayit/constants/helpers.dart';

class ChangeProfilePicture extends StatefulWidget {
  const ChangeProfilePicture({super.key});

  @override
  State<ChangeProfilePicture> createState() => _ChangeProfilePictureState();
}

class _ChangeProfilePictureState extends State<ChangeProfilePicture> {
  FirebaseStorage storage = FirebaseStorage.instance;
  String? userFullname;
  String? username;
  String? pictureurl;
  File? _image;
  String selectedFile = "";
  final picker = ImagePicker();
  Uint8List? selectedImageInBytes;
  String? userPhotoUrl;

  Future uploadFile() async {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    Reference storageRef =
        storage.ref("profile_pictures").child("$currentUserID.png");

    if (Plateforme.isMobile()) {
      UploadTask uploadTask = storageRef.putFile(_image!);
      ShowProgressIndicators.circular(context);
      await uploadTask.whenComplete(() {
        storageRef.getDownloadURL().then((downloadedUrl) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(currentUserID)
              .update({"pictureurl": downloadedUrl.toString()});
          Navigator.pop(context);
          ShowDialog.succes(context, "File uploaded successfully");
        
        });
      });
    } else {
      final metadata = SettableMetadata(contentType: "image/png");
      UploadTask uploadTask =
          storageRef.putData(selectedImageInBytes!, metadata);
      ShowProgressIndicators.circular(context);
      await uploadTask.whenComplete(() {
        Navigator.pop(context);
        ShowDialog.succes(context, "File uploaded successfully");
        
      });
    }
  }

  Future getImageMobile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future selectFile() async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (fileResult != null) {
      setState(() {
        selectedFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes;
      });
    }
  }

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
          userFullname = doc.get("fullname");
          username = doc.get("username");
          pictureurl = doc.get("pictureurl");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Change Profile Picture",
        style: TextStyle(color: Colors.black),
      ),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Plateforme.isMobile()
                  ? _image == null
                      ? const Text("No image selected.")
                      : circleAvatar(
                          Image.file(_image!,
                              fit: BoxFit.cover, width: 200.0, height: 200.0),
                          context)
                  : selectedFile.isEmpty
                      ? const Text("No image selected.")
                      : circleAvatar(
                          Image.memory(selectedImageInBytes!,
                              fit: BoxFit.cover, width: 200.0, height: 200.0),
                          context),
              const SizedBox(height: 25),
              const SizedBox(height: 25),
              OutlinedButton(
                  onPressed: () =>
                      Plateforme.isMobile() ? getImageMobile() : selectFile(),
                  child: const Text("Browse Image")),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "CANCEL",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            uploadFile();
            Navigator.pop(context);
          },
          child: const Text(
            "APPLY",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}

Widget circleAvatar(Image image, BuildContext context) => ClipOval(
    child: InkWell(highlightColor: Colors.white, child: image, onTap: () {}));
