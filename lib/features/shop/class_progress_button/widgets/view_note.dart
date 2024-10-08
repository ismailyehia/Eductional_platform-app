

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/features/shop/class_progress_button/progress_details.dart';
import 'package:quran_tdress/features/shop/class_progress_button/widgets/show_dialog_lesson.dart';
import 'package:quran_tdress/provider/classprovider/get_progress_provider.dart';

class ViewNoteScreen extends StatefulWidget {
  ViewNoteScreen(
      {super.key,
      required this.note,
      required this.courseid,
      required this.date}) {
    noteController.text = note;
    dateController.text = date;
  }

  final String note;
  final String date;

    final TextEditingController dateController = TextEditingController();

  final TextEditingController noteController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();

  final int courseid;

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
    String? selectedLesson;


  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context );
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('Update Your data',style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 24,
            ),),

            SizedBox(height: 12,),
            const Text(
              "Date",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: widget.dateController,
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

            const SizedBox(height: 15,),

            
            GestureDetector(
              onTap: () {
                final lessons = progressProvider.progressList
                    .map((progress) => progress.lesson?.name)
                    .where((name) => name != null)
                    .map((name) => name!)
                    .toList();
        
                if (lessons.isEmpty) {
                  print("No lessons available");
                  return;
                }
        
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LessonDialog(
                      lessons: lessons,
                      onLessonSelected: (selectedLesson) {
                        setState(() {
                          this.selectedLesson = selectedLesson;
                        });
                      },
                    );
                  },
                );
              },
              child: TRoundedContainer(
                margin: const EdgeInsets.only(left: 8),
                width: 360,
                height: 60,
                backgroundColor: const Color(0xFF7f56dD),
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 120,
                ),
                child: Row(children: [
                  Text(selectedLesson ?? "Lesson",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 70,
                  ),
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 30,
                    color: Colors.white,
                  )
                ]),
              ),
            ),


            const SizedBox(height: 7,),


            const Text(
              "Score",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: widget.scoreController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(width: 1)),
                labelText: "Enter Score untill 10",
                prefixIcon: Icon(Iconsax.calendar),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 17, horizontal: 12),
              ),
            ),






            const SizedBox(
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
                  controller: widget.noteController,
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
              margin: const EdgeInsets.only(left: 10),
              width: 300,
              height: 60,
              backgroundColor: const Color(0xFF7F56D9),
              padding: const EdgeInsets.only(
                top: 5,
                left: 130,
              ),
              child: InkWell(
                onTap: () {
                  String updatedNote = widget.noteController.text;

                  String updatedDate = widget.dateController.text;
                  print(" Course id is :${widget.courseid}");

                  Provider.of<ProgressProvider>(context, listen: false)
                      .updateProgressNote(
                        context: context,
                    updatedNote: updatedNote,
                    courseId: widget.courseid,
                    date: updatedDate,
                  ).then((_) {
    // Navigate back to ProgressDetails and reload the screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgressDetails(courseeid: widget.courseid),
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
              margin: EdgeInsets.only(left: 10),
              showBorder: true,
              borderColor: const Color(0xFF475467),
              width: 300,
              height: 60,
              backgroundColor: Colors.white,
              padding: const EdgeInsets.only(
                top: 5,
                left: 130,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
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
                          color: Colors.black,
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


