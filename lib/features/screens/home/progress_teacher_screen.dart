import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/features/screens/home/widgets/get_student_course.dart';
import 'package:quran_tdress/features/shop/attendence_button/attendence_button.dart';
import 'package:quran_tdress/features/shop/class_progress_button/class_progress_button.dart';
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
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClassRoomProvider>(context, listen: false)
          .fetchClassRoomData(widget.classid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final classRoomProvider = Provider.of<ClassRoomProvider>(context);

    return Scaffold(
      appBar: AppBar(),
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

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttendenceButton(
                            classnamee: widget.classname,
                            classId: widget.classid,
                          )),
                );
              },
              child: const TRoundedContainer(
                // borderwidth: 3,
                // showBorder: true,
                width: 380,
                height: 55,
                radius: 12,
                padding: EdgeInsets.only(top: 7, left: 130),
                backgroundColor: Color(0xFF7F56D9),
                child: Text(
                  "Attendence",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClassProgress(
                            classnameee: widget.classname,
                            classId: widget.classid,
                          )),
                );
              },
              child: const TRoundedContainer(
                // borderwidth: 3,
                // showBorder: true,
                width: 380,
                height: 55,
                radius: 12,
                padding: EdgeInsets.only(top: 7, left: 100),
                backgroundColor: Color(0xFF7F56D9),
                child: Text(
                  "Class Progress",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

          
            const SizedBox(
              height: 30,
            ),

            const Divider(thickness: 1,),
            
            Text("Students in this Class",
                style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(
              height: 15,
            ),

            TextField(
                controller: searchcontroller,
                onChanged: (value) {
                  classRoomProvider.updatelist(value);
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1)),
                    labelText: "Search Students",
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ))),
            const SizedBox(
              height: 15,
            ),

            //
            Expanded(
              child: classRoomProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  :  classRoomProvider.classRoom == null || classRoomProvider.filterdstudents.isEmpty
                      ? const Center(child: Text("No students found"))
                      : ListView.builder(
                          itemCount:classRoomProvider.filterdstudents.length,
                          itemBuilder: (context, index) {
                            final student = classRoomProvider.filterdstudents[index];
                            return GestureDetector(
                              onTap: () {
                                print(" Student id is :${student.id}");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StudentCoursesScreen(
                                              studentId: student.id,
                                            )));
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
                                title: Text(
                                  student.name,
                                  style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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



