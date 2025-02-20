import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/models/student_attendence.dart';
import 'package:quran_tdress/provider/classprovider/attendence_provider.dart';
import 'package:quran_tdress/provider/classprovider/class_students_provider.dart';

class AttendenceButton extends StatefulWidget {
  const AttendenceButton(
      {super.key, required this.classnamee, required this.classId});

  final String classnamee;
  final int classId;



  @override
  State<AttendenceButton> createState() => _AttendenceButtonState();
}

class _AttendenceButtonState extends State<AttendenceButton> {
  Map<int, bool> studentAttendance = {}; // Track present/absent state




  @override
  void initState() {
    super.initState();
    // Fetch classroom data
    final classRoomProvider =
        Provider.of<ClassRoomProvider>(context, listen: false);
    classRoomProvider.fetchClassRoomData(widget.classId);
  }

  // Toggle attendance state (Present = true, Absent = false)
  void toggleAttendance(int studentId, bool isPresent) {
    setState(() {
      studentAttendance[studentId] = isPresent;
    });
  }

  //save attendenc

  void saveAttendance() {
    // final classRoomProvider =Provider.of<ClassRoomProvider>(context, listen: false);

    List<StudentAttendance> attendanceData =studentAttendance.entries.map((entry) {
      return StudentAttendance(
        userId: entry.key,
        hasAttended: entry.value,
      );
    }).toList();

    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(now);

    AttendanceModel attendanceModel = AttendanceModel(
      students: attendanceData,
      date: date,
    );
    final attendanceProvider =Provider.of<AttendanceProvider>(context, listen: false);
    attendanceProvider.saveAttendance(attendanceModel, context);
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController dateController = TextEditingController();
    dateController.text = DateTime.now().toString().substring(0, 10);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                widget.classnamee,
                style: Theme.of(context).textTheme.headlineMedium,
              )),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Attendance Sheet",
                style: Theme.of(context).textTheme.headlineMedium,
              )),
              const SizedBox(
                height: 15,
              ),
        
              // Date Filter
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
              const SizedBox(
                height: 30,
              ),
        
              // Mark Students
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Mark all students as present
                      setState(() {
                        for (var student in studentAttendance.keys) {
                          studentAttendance[student] = true; // Set all to present
                        }
                      });
                    },
                    child: const TRoundedContainer(
                      width: 190,
                      height: 70,
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.only(
                        top: 6,
                        left: 30,
                      ),
                      child: Text("Mark All as Present",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Mark all students as absent
                      setState(() {
                        for (var student in studentAttendance.keys) {
                          studentAttendance[student] = false; // Set all to absent
                        }
                      });
                    },
                    child: const TRoundedContainer(
                      width: 170,
                      height: 70,
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.only(
                        top: 6,
                        left: 30,
                      ),
                      child: Text("Mark All as Absent",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
        
              const SizedBox(
                height: 13,
              ),
        
              const Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text("Student name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Present",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Absent",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ],
              ),
        
              const SizedBox(
                height: 5,
              ),
        
              Consumer<ClassRoomProvider>(
                  builder: (context, classRoomProvider, child) {
                if (classRoomProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                      
                if (classRoomProvider.classRoom == null) {
                  return const Center(child: Text("No data available"));
                }
                      
                final students = classRoomProvider.classRoom?.students ?? [];
                      
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                      
                    // Initialize attendance state if not set
                    if (!studentAttendance.containsKey(student.id)) {
                      studentAttendance[student.id] = true;
                    }
                      
                    final isPresent = studentAttendance[student.id] ?? true;
                      
                    return Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              student.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                overflow:
                                    TextOverflow.ellipsis, // Prevent overflow
                              ),
                              maxLines: 1,
                            ),
                          ),
                          // Present option with arrow
                          GestureDetector(
                            onTap: () => toggleAttendance(student.id, true),
                            child: CircleAvatar(
                              radius: 17,
                              child: Icon(
                                isPresent ? Icons.check_circle  : Icons.check,
                                color: isPresent ? Colors.green : Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 90), // Space between present and absent
                          // Absent option with arrow
                          GestureDetector(
                            onTap: () => toggleAttendance(student.id, false),
                            child: CircleAvatar(
                              radius: 17,
                              child: Container(
                                child: Icon(
                                  !isPresent
                                      ? Iconsax.close_circle5
                                      : Icons.close_rounded,
                                  color: !isPresent ? Colors.red : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
        
              // Save Button
              GestureDetector(
                onTap: () {
                  saveAttendance();
                },
                child: const TRoundedContainer(
                  margin: EdgeInsets.only(top: 40),
                  width: 400,
                  height: 60,
                  backgroundColor: Color(0xFF7F56D9),
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 170,
                  ),
                  child: Text("Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
