import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quran_tdress/navigation_menu_teacher.dart';

class Studentsprofileshow extends StatelessWidget {
  const Studentsprofileshow(
      {super.key,
      required this.name,
      required this.email,
      required this.photourl, required this.studentId});

  final String name;
  final String email;
  final String photourl;
  final int studentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const NavigationMenuTeacher()));
          },
          icon: const Icon(
            Iconsax.arrow_left,
            size: 25,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, top: 14),
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(name),
              ),
              const SizedBox(
                width: 7,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  email,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ])
            ])
          ],
        ),
      ),
    );
  }
}
