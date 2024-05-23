import 'package:flutter/material.dart';
import 'package:sayit/features/user_profile/widgets/profile_appbar.dart';

class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: profileAppBar(),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 10),
              personnalizedField("Name"),
              const SizedBox(height: 12),
              personnalizedField(""),
              OutlinedButton(
                onPressed: () {},
                child: const Text(
                  "Save changes",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget personnalizedField(String hintext) {
  return TextField(
    decoration:
        InputDecoration(border: const OutlineInputBorder(), labelText: hintext),
  );
}
