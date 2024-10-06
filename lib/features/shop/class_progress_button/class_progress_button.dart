
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/features/shop/class_progress_button/progress_details.dart';
import 'package:quran_tdress/features/shop/class_progress_button/progress_details_quran.dart';
import 'package:quran_tdress/provider/classprovider/class_courses_provider.dart';

class ClassProgress extends StatelessWidget {
  const ClassProgress(
      {super.key, required this.classnameee, required this.classId});

  final String classnameee;
  final int classId;

  @override
  Widget build(BuildContext context) {
    final classProvider =
        Provider.of<ClassCourseProvider>(context, listen: false);

    // Ensure the data is fetched when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      classProvider.fetchClassData(classId);
    });

    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Consumer<ClassCourseProvider>(
        builder: (context, classProvider, child) {
          if (classProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final classModel = classProvider.classModel;

          if (classModel == null) {
            return const Center(child: Text("No class data available"));
          }

          return Column(
            children: [
              const SizedBox(height: 20),
              Text(
                classnameee,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Class Progress",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    // childAspectRatio: 1,
                  ),
                  itemCount: classModel.courses.length,
                  itemBuilder: (context, index) {
                    final course = classModel.courses[index];

                    return GestureDetector(
                      onTap: () {
                        print(" Course id is :${course.id}");
                        if (course.type == "quran") {
                          // Navigate to a different page if the course type is "quran"
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProgressDetailsQuran(courseeeid: course.id),
                            ),
                          );
                        } else {
                          // Otherwise, navigate to the existing ProgressDetails page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProgressDetails(courseeid: course.id),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              course.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CircleAvatar(
                              radius: 30,
                              child: Text("${course.progress}%"),
                            ),
                          ],
                        ),
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
