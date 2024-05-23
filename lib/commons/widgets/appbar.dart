import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:sayit/constants/assets.dart';
import 'package:sayit/constants/helpers.dart';
import 'package:sayit/features/home/widgets/signoutdialog.dart';
import 'package:sayit/features/user_profile/views/web_profile_view.dart';

AppBar webAppBar = AppBar(
  foregroundColor: Colors.black,
  centerTitle: true,
  title: const Text(
    "Home",
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
  backgroundColor: Colors.blueGrey[50],
  elevation: 2,
);

AppBar mobileAppBar(BuildContext context, String? pictureurl) {
  return AppBar(
    foregroundColor: Colors.grey,
    actions: [
      Container(
        margin: const EdgeInsets.only(right: 5),
        child: InkWell(
          onTap: () {
            HomeDialog.signOutConfirmation(context);
          },
          child: const Icon(FluentSystemIcons.ic_fluent_sign_out_filled),
        ),
      )
    ],
    centerTitle: true,
    title: Image.asset(
      LogosAssets.sayitLogo,
      scale: 11,
    ),
    backgroundColor: Colors.blueGrey[50],
    elevation: 2,
    leading: Container(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () => Helpers.goto(context, const UserProfileView()),
        child: pictureurl != null
            ? CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(pictureurl),
              )
            : const CircularProgressIndicator(),
      ),
    ),
  );
}
