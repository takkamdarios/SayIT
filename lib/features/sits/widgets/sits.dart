import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sayit/commons/services/platform_check.dart';
import 'package:sayit/constants/assets.dart';
import 'package:sayit/constants/helpers.dart';
import 'package:sayit/features/sits/widgets/sit_sections.dart';
import 'package:sayit/features/user_profile/views/web_profile_view.dart';

class SitCard extends StatefulWidget {
  final String sitID;
  final String currentUserID;
  final String userfullname;
  final String username;
  final String sitContent;
  final String sitUserID;
  final String pictureurl;

  const SitCard(
      {super.key,
      required this.sitID,
      required this.currentUserID,
      required this.userfullname,
      required this.username,
      required this.sitContent,
      required this.sitUserID,
      required this.pictureurl});

  @override
  State<SitCard> createState() => _SitCardState();
}

class _SitCardState extends State<SitCard> {
  bool isLiked = false;
  int likeCount = 0;

  StreamSubscription<QuerySnapshot>? likesSubscription;

  @override
  void initState() {
    super.initState();
    checkIfLiked();
    startlikesSubscription();
  }

  void startlikesSubscription() {
    likesSubscription = FirebaseFirestore.instance
        .collection('likes')
        .where('sitID', isEqualTo: widget.sitID)
        .snapshots()
        .listen((querySnapshot) {
      setState(() {
        likeCount = querySnapshot.docs.length;
      });
    });
  }

  void checkIfLiked() {
    FirebaseFirestore.instance
        .collection("likes")
        .where("sitID", isEqualTo: widget.sitID)
        .where("userID", isEqualTo: widget.currentUserID)
        .get()
        .then((querySnapshot) {
      if (mounted) {
        setState(() {
          isLiked = querySnapshot.docs.isNotEmpty;
        });
      }
    });
  }

  void likeSit() {
    FirebaseFirestore.instance.collection('likes').add({
      'sitID': widget.sitID,
      'userID': widget.currentUserID,
    }).then((_) {
      setState(() {
        isLiked = true;
      });
    });
  }

  void unlikeSit() {
    FirebaseFirestore.instance
        .collection('likes')
        .where('sitID', isEqualTo: widget.sitID)
        .where('userID', isEqualTo: widget.currentUserID)
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete().then((_) {
          setState(() {
            isLiked = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                widget.sitUserID != widget.currentUserID
                    ? Plateforme.isWeb()
                        ? showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: SizedBox(
                                    width: 600,
                                    child: UserProfileView(
                                      otherUser: true,
                                      otherUserID: widget.sitUserID,
                                    ),
                                  ),
                                ))
                        : Helpers.goto(
                            context,
                            UserProfileView(
                              otherUser: true,
                              otherUserID: widget.sitUserID,
                            ))
                    : null;
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.pictureurl),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userfullname,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.username,
                            style: TextStyle(color: Colors.blueGrey[400]),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 60, bottom: 15),
              child: Text(
                widget.sitContent,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 60),
                InkWell(
                  highlightColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  onTap: () {
                    isLiked ? unlikeSit() : likeSit();
                  },
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: isLiked
                        ? SvgPicture.asset(
                            SvgsAssets.likeFilledIcon,
                            // ignore: deprecated_member_use
                            color: const Color.fromRGBO(249, 25, 127, 1),
                          )
                        : SvgPicture.asset(
                            SvgsAssets.likeOutlinedIcon,
                            // ignore: deprecated_member_use
                            color: Colors.grey,
                          ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(likeCount.toString()),
                const SizedBox(width: 25),
                resitSection,
                const SizedBox(width: 25),
                commentSection,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
