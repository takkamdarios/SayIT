import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sayit/commons/services/platform_check.dart';
import 'package:sayit/commons/widgets/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sayit/features/authentication/services/email_verification.dart';
import 'package:sayit/features/authentication/services/firebase_auth.dart';
import 'package:sayit/features/authentication/views/auth_view.dart';
import 'package:sayit/features/home/view/web_home.dart';
import 'package:sayit/firebase_options.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TweetModel extends StatefulWidget {
  const TweetModel({super.key});
  @override
  State<TweetModel> createState() => _TweetModelState();
}

class _TweetModelState extends State<TweetModel> {
  int likeCount = 0;
  List<String> comments = [];
  int retweetCount = 0;
  File? imageFile;

  void _incrementLikes() {
    setState(() {
      likeCount++;
    });
  }

  void incrementComments(String comment) {
    setState(() {
      comments.add(comment);
    });
  }

  void _incrementRetweets() {
    setState(() {
      retweetCount++;
    });
  }

  void _submitComment(String comment) {
    setState(() {
      comments.add(comment);
    });
    // Perform any additional actions with the comment, such as sending it to a server or storing it locally.
    //print('Submitted comment: $comment');
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweet Model'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'This is a tweet.',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                // User profile picture
                backgroundImage: AssetImage('assets/profile_picture.png'),
              ),
              title: const Text('John Doe'), // User name
              subtitle:
                  const Text('Lorem ipsum dolor sit amet'), // Tweet content
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: _incrementLikes,
                  ),
                  Text('$likeCount'),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController commentController =
                              TextEditingController();
                          return AlertDialog(
                            title: const Text('Enter Comment'),
                            content: Column(
                              children: [
                                TextField(
                                  controller: commentController,
                                ),
                                const SizedBox(height: 8.0),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _submitComment(commentController.text);
                                  },
                                  child: const Text('Submit'),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Text('${comments.length}'),
                  IconButton(
                    icon: const Icon(Icons.repeat),
                    onPressed: _incrementRetweets,
                  ),
                  Text('$retweetCount'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index]),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Upload Image'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Take a photo'),
                          onTap: () {
                            _pickImage(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.image),
                          title: const Text('Choose from gallery'),
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Upload Image'),
          ),
          if (imageFile != null) Image.file(imageFile!),
        ],
      ),
    );
  }
}

FirebaseAuth auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  auth.authStateChanges().listen((User? user) async {
    /// runApp(MaterialApp(
    //  home: TweetModel(),
    ////));

    if (user == null) {
      runApp(const AuthView());
    } else {
      if (!user.emailVerified) {
        runApp(const VerifyEmail());
      } else {
        bool isDocumentExists = await UserInfos.checkDocumentExists();
        if (!isDocumentExists) {
          UserFirebaseController().addUser(
              user.uid,
              user.displayName.toString(),
              user.email.toString().substring(0, 9),
              user.photoURL!);
        }
        Plateforme.isMobile()
            ? runApp(const BottomBar())
            : runApp(const WebHomeView());
      }
    }
  });
}

class UserInfos {
  static Future<bool> checkDocumentExists() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return snapshot.exists;
  }
}
