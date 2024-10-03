import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/common/custom/custom_button.dart';
import 'package:quran_tdress/features/screens/home/widgets/get_student_course.dart';
import 'package:quran_tdress/features/shop/attendence_button/attendence_button.dart';
import 'package:quran_tdress/features/shop/class_progress_button/class_progress_button.dart';
import 'package:quran_tdress/navigation_menu_teacher.dart';
import 'package:quran_tdress/provider/classprovider/class_students_provider.dart';

class ProgressTeacher extends StatefulWidget {
  const ProgressTeacher({
    super.key,
    required this.classname,
    required this.classid,
  });

  final String classname;
  final int classid;

  @override
  State<ProgressTeacher> createState() => _ProgressTeacherState();
}

class _ProgressTeacherState extends State<ProgressTeacher> {

  void initState() {
    super.initState();
    // Fetch progress data when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClassRoomProvider>(context, listen: false).fetchClassRoomData(widget.classid);
    });
  }
  @override
  Widget build(BuildContext context) {
    final classRoomProvider = Provider.of<ClassRoomProvider>(context);


    return Scaffold(
      appBar: AppBar(actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const NavigationMenuTeacher()),
              icon: const Icon(CupertinoIcons.clear)),
        ],),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              widget.classname,
              style: Theme.of(context).textTheme.headlineMedium,
            )),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
                text: "Attendence",
                color: Colors.purple,
                func: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AttendenceButton(
                              classnamee: widget.classname,
                              classId: widget.classid,
                            )), // Your Supervisor Page
                  );
                }),
            const SizedBox(
              height: 32,
            ),
            CustomButton(
              text: "Class Progress",
              color: Colors.purple,
              func: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClassProgress(
                            classnameee: widget.classname,
                            classId: widget.classid,
                          )),
                );
              },
            ),

            SizedBox(
              height: 30,
            ),
            Text("Students in this Class",
                style: Theme.of(context).textTheme.headlineMedium),

                SizedBox(height: 15,),

            // Displaying students
            Expanded(
              child: classRoomProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : classRoomProvider.classRoom == null ||
                          classRoomProvider.classRoom!.students.isEmpty
                      ? const Center(child: Text("No students found"))
                      : ListView.builder(
                          itemCount:
                              classRoomProvider.classRoom!.students.length,
                          itemBuilder: (context, index) {
                            final student =
                                classRoomProvider.classRoom!.students[index];
                            return GestureDetector(
                              onTap: () {
                                print(" Student id is :${student.id}");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  StudentCoursesScreen(studentId: student.id,)));
                              },
                              child: ListTile(
                                leading: student
                                        .profile.profilePhotoUrl.isNotEmpty
                                    ? CircleAvatar(
                                      radius: 24,
                                        backgroundImage: NetworkImage(
                                            student.profile.profilePhotoUrl),
                                      )
                                    : const CircleAvatar(
                                        child: Icon(
                                            Icons.person)), // Placeholder icon
                                title: Text(student.name,style: TextStyle(fontSize: 23,),),
                              
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}


