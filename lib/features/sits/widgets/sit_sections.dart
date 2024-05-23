import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sayit/constants/assets.dart';

Widget commentSection = Row(
  children: [
    InkWell(
      onTap: () {},
      child: SizedBox(
          width: 20,
          height: 20,
          child: SvgPicture.asset(
            SvgsAssets.commentIcon,
            // ignore: deprecated_member_use
            color: Colors.grey,
          )),
    ),
    const SizedBox(width: 12),
    const Text("0"),
  ],
);

Widget resitSection = Row(
  children: [
    InkWell(
      onTap: () {},
      child: SizedBox(
          width: 20,
          height: 20,
          child: SvgPicture.asset(
            SvgsAssets.resitIcon,
            // ignore: deprecated_member_use
            color: Colors.grey,
          )),
    ),
    const SizedBox(width: 12),
    const Text("0"),
  ],
);
