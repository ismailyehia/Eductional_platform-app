import 'package:flutter/material.dart';

class LessonDialog extends StatelessWidget {
  LessonDialog({required this.lessons});

    final List<String> lessons;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Lessons'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: lessons.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(lessons[index]),
              onTap: () {
                // You can handle onTap logic here if necessary
                Navigator.pop(
                    context); // Dismiss the dialog when a lesson is selected
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
        ),
      ],
    );
  }
}
