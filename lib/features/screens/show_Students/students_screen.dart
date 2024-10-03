import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/features/screens/show_Students/students_profile.dart';
import 'package:quran_tdress/provider/studentprovider/student_provider.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() =>
        Provider.of<StudentProvider>(context, listen: false).fetchStudents());
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<StudentProvider>(
        builder: (context, studentProvider, child) {
          if (studentProvider.isLoading) {
            // Show loading spinner while data is being fetched
            return const Center(child: CircularProgressIndicator());
          }

          if (studentProvider.students.isEmpty) {
            // Show a message if no students are available
            return const Center(child: Text('No students available'));
          }

          // Display the list of students once the data is fetched
          return Column(
            children: [
              const Text(
                "All Students",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20), // Space below the title
              Expanded(
                child: ListView.builder(
                  itemCount: studentProvider.students.length,
                  itemBuilder: (context, index) {
                    final student = studentProvider.students[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Studentsprofileshow(
                                    name: student.name,
                                    email: student.email,
                                    photourl: student.profile.profilePhotoUrl),
                                    ));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(student.profile.profilePhotoUrl),
                        ),
                        title: Text(student.name),
                        subtitle: Text(student.email),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
