import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/features/shop/class_progress_button/progress_details.dart';
import 'package:quran_tdress/provider/classprovider/get_progress_provider.dart';

class ViewNoteScreen extends StatelessWidget {
  ViewNoteScreen(
      {super.key,
      required this.note,
      required this.courseid,
      required this.date}) {
    noteController.text = note;
    dateController.text = date;
  }

  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final String note;
  final String date;

  final int courseid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Date",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: dateController, // User can edit the date
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(width: 1)),
                labelText: "Enter date",
                prefixIcon: Icon(Iconsax.calendar),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 17, horizontal: 12),
              ),
            ),

            SizedBox(
              height: 7,
            ),
            const Text(
              "Edit Your Note Here",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: noteController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: "Write Note here",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Save Button
            TRoundedContainer(
              width: 300,
              height: 60,
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.only(
                top: 5,
                left: 130,
              ),
              child: InkWell(
                onTap: () {
                  String updatedNote = noteController.text;

                  String updatedDate = dateController.text;
                  print(" Course id is :$courseid");

                  Provider.of<ProgressProvider>(context, listen: false)
                      .updateProgressNote(
                        context: context,
                    updatedNote: updatedNote,
                    courseId: courseid,
                    date: updatedDate,
                  ).then((_) {
    // Navigate back to ProgressDetails and reload the screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProgressDetails(courseeid: courseid),
      ),
    );
  });

                  // Optionally, navigate back or show confirmation
                  // Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TRoundedContainer(
              width: 300,
              height: 60,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.only(
                top: 5,
                left: 130,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ProgressDetails(courseeid: 0)));
                },
                child: const Row(
                  children: [
                    Text(
                      "Close",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


