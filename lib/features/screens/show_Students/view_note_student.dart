import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/features/screens/show_Students/progress_details_with_score.dart';
import 'package:quran_tdress/features/shop/class_progress_button/widgets/show_dialog_lesson.dart';
import 'package:quran_tdress/provider/classprovider/get_progress_provider.dart';

// ignore: must_be_immutable
class ViewNoteScreenStudent extends StatefulWidget {
  ViewNoteScreenStudent(
      {super.key,
      required this.studentId,
      required this.note,
      required this.progressid,
      required this.courseid,
      required this.date,
      this.score,
      //  required this.classid
      }) {
    noteController.text = note!;
    dateController.text = date;
    scoreController.text = score != null ? score.toString() : '';
    lessoncontroller.text = selectedLesson ?? '';
  }

  final int studentId;

  final String? note;
  final String date;
  final int? score;
  String? selectedLesson;
  final int progressid;
  // final int classid;


  final TextEditingController dateController = TextEditingController();

  final TextEditingController noteController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();
  final TextEditingController lessoncontroller = TextEditingController();

  final int courseid;

  @override
  State<ViewNoteScreenStudent> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreenStudent> {
  String? selectedLesson;

  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Update Your data',
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            const SizedBox(
              height: 12,
            ),
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

            const SizedBox(
              height: 15,
            ),

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

            const SizedBox(
              height: 7,
            ),

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
                  int score = int.parse(widget.scoreController.text);
                  if (score < 0 || score > 10) {
                    throw const FormatException(
                        "Score must be between 0 and 10");
                  }

                  String updatedDate = widget.dateController.text;
                  print(" Course id is :${widget.courseid}");

                  print("Progress Id : ${widget.progressid}");

                  Provider.of<ProgressProvider>(context, listen: false)
                      .updatestudentProgressNote(
                        studentid: widget.studentId,
                    progressId: widget.progressid,
                    score: score,
                    context: context,
                    updatedNote: updatedNote,
                    courseId: widget.courseid,
                    date: updatedDate,
                    lessonid: int.tryParse(widget.lessoncontroller.text) ?? 1,
                  )
                      .then((_) {
                    // Navigate back to ProgressDetails and reload the screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProgressDetailsScore(courseeid: widget.courseid, studentid: widget.studentId,),
                      ),
                    );
                  });
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
              margin: const EdgeInsets.only(left: 10, bottom: 10),
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
                              ProgressDetailsScore(courseeid: widget.courseid, studentid: widget.studentId,)));
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


