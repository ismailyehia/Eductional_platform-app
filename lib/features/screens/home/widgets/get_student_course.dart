
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/features/screens/home/widgets/date_calender.dart';
import 'package:quran_tdress/features/shop/class_progress_button/progress_details.dart';
import 'package:quran_tdress/features/shop/class_progress_button/progress_details_quran.dart';
import 'package:quran_tdress/provider/studentprovider/student_courses_provider.dart';

class StudentCoursesScreen extends StatefulWidget {
  const StudentCoursesScreen({super.key, required this.studentId});

  final int studentId;

  @override
  State<StudentCoursesScreen> createState() => _StudentCoursesScreenState();

}

class _StudentCoursesScreenState extends State<StudentCoursesScreen> {
    bool _showCalendar = false;

    
  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentsProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentProvider.fetchStudentData(widget.studentId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Consumer<StudentsProvider>(
          builder: (context, value, child) {
            return Text(
              studentProvider.student != null
                  ? studentProvider.student!.name
                  : "",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      body: Consumer<StudentsProvider>(
        builder: (context, studentProvider, child) {
          if (studentProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final studentModel = studentProvider.student;
          
          // Check if studentModel is null
          if (studentModel == null) {
            print("Error: Student model is null.");
            return const Center(child: Text("No student data available"));
          }

          final attendance = studentModel.attendances;

          final profile = studentModel.profile;

          return Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to the start
            children: [
              // Student Name
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Text(
              //     studentModel.name,
              //     style: const TextStyle(
              //       fontSize: 24,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
          
              // Age and Created At
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Text(
                      "Age: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      profile.age.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    const Text(
                      "Created at: ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 20),
          
              // Other Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Text(
                      "Other Info: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      profile.sex,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 15),
          
              // Courses Grid
              SizedBox(
                height: 200,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: studentModel.courses.length,
                  itemBuilder: (context, index) {
                    final course = studentModel.courses[index];
          
                    return GestureDetector(
                      onTap: () {
                        print("Course id is : ${course.id}");
                        if (course.type == "quran") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProgressDetailsQuran(courseeeid: course.id),
                            ),
                          );
                        } else {
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
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: CircularProgressIndicator(
                                    value: course.progress /
                                        100, // progress fraction
                                    strokeWidth:
                                        6, // thickness of the progress tape
                                    backgroundColor: Colors
                                        .grey[300], // background tape color
                                    color: const Color(
                                        0xFF7f56d9), // progress color
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    "${course.progress}%",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          
              const SizedBox(height: 2),
          
              // Attendance Report Header
              Row(
                children: [
                  const Text(
                    "Attendance Report:",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _showCalendar = false;
                        });
                      }, icon: const Icon(Iconsax.clipboard)),
                  IconButton(
                      onPressed: () {
                        
                        setState(() {
                          _showCalendar = true;
                        });
                        
                        // // Attendance? attendence;
                        // // Navigator.push(
                        // //     context,
                        // //     MaterialPageRoute(
                        // //         builder: (context) => DateCalender(
                        // //           attendances: attendance,
                        // //               // hasattended: attendence!.hasAttended,
                        // //             )));
                      },
                      icon: const Icon(Iconsax.calendar)),
                ],
              ),
          
              const SizedBox(height: 10),
          
              
          
              // Attendance Date Label
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(children: [
                  Text(
                    "Date:",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                  ),
                  Text(
                    "P/A",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
          
              const SizedBox(height: 15),
          
              // Attendance List
          
              Expanded(
                child: _showCalendar ? DateCalender(attendances: attendance ) : 
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: studentModel.attendances.length,
                  itemBuilder: (context, index) {
                    final attendance = studentModel.attendances[index];
                    print(
                        "Attendance Date: ${attendance.date}, Status: ${attendance.hasAttended}");
                            
                    return Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 3, right: 40),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            attendance.date,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                            
                          const SizedBox(
                            width: 60,
                          ),
                          attendance.hasAttended == 1
                              ? const Icon(
                                  Icons.check_box_rounded,
                                  color: Colors.green,
                                  size: 30,
                                ) // Check icon if attended
                              : const Icon(Icons.close_outlined,
                                  color: Colors.red,
                                  size: 30), // Close icon if not attended
                        ],
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



