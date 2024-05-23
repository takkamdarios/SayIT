import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sayit/features/user_profile/services/edit_profile_picture.dart';
import 'package:sayit/features/user_profile/widgets/follows.dart';
import 'package:sayit/features/user_profile/widgets/profile_appbar.dart';
import 'package:sayit/features/user_profile/widgets/tabbar.dart';

class UserProfileView extends StatefulWidget {
  final bool otherUser;
  final String otherUserID;
  const UserProfileView(
      {super.key, this.otherUser = false, this.otherUserID = ""});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  FirebaseStorage storage = FirebaseStorage.instance;
  String? userFullname;
  String? username;
  String? pictureurl;

  @override
  void initState() {
    super.initState();
    getUserProfileData();
  }

  getUserProfileData() {
    String currentUserID = !widget.otherUser
        ? FirebaseAuth.instance.currentUser!.uid
        : widget.otherUserID;
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
    Widget profilePictureSection = Positioned(
      top: 45,
      left: 20,
      child: pictureurl != null
          ? CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  backgroundImage: NetworkImage(pictureurl!)),
            )
          : const CircularProgressIndicator(),
    );

    Widget profileNameSection() {
      if (username == null || userFullname == null) {
        return const CircularProgressIndicator();
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userFullname!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              username!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey[400],
              ),
            ),
          ],
        );
      }
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: profileAppBar(bgColor: Colors.blueGrey[100]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  color: Colors.blueGrey[100],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 110),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 20),
                            child: !widget.otherUser
                                ? Column(
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const ChangeProfilePicture());
                                        },
                                        child: const Text(
                                          "Change Profile Picture",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "Change Email Address",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "Follow",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  ),
                          )
                        ],
                      ),
                      profileNameSection(),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          userFollowSection(
                              collection: "following",
                              text: "Following",
                              userID: widget.otherUserID,
                              otherUser: widget.otherUser),
                          const SizedBox(width: 10),
                          userFollowSection(
                              collection: "followers",
                              text: "Followers",
                              userID: widget.otherUserID,
                              otherUser: widget.otherUser),
                        ],
                      )
                    ],
                  ),
                ),
                profilePictureSection,
              ],
            ),
            const SizedBox(height: 16),
            profileTabBar,
            profileTabBarView,
          ],
        ),
      ),
    );
  }
}

Widget userFollowSection(
        {required String collection,
        required String text,
        required String userID,
        required bool otherUser}) =>
    Row(
      children: [
        CountUserFollows(
          type: collection,
          userID: userID,
          otherUser: otherUser,
        ),
        const SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.blueGrey[400],
          ),
        ),
      ],
    );
