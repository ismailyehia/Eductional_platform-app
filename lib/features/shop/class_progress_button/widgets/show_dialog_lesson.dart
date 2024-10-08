import 'package:flutter/material.dart';
class LessonDialog extends StatelessWidget {
  final List<String> lessons;
  final Function(String) onLessonSelected; // Add this callback

  LessonDialog({required this.lessons, required this.onLessonSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Lesson'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: lessons.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(lessons[index]),
              onTap: () {
                onLessonSelected(lessons[index]); // Call the callback
                Navigator.of(context).pop(); // Close the dialog
              },
            );
          },
        ),
      ),
    );
  }
}
