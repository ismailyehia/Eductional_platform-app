import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/features/screens/home/widgets/get_student_course.dart';
import 'package:quran_tdress/provider/studentprovider/student_provider.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {


  @override
    void initState() {
    super.initState();
        Future.microtask(() =>
        Provider.of<StudentProvider>(context, listen: false).fetchStudents());
  
  }

          TextEditingController searchcontroller = TextEditingController();


  @override


  Widget build(BuildContext context) {

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
              const SizedBox(height: 10,),

              TextField(
                controller: searchcontroller,
                onChanged: (value) {
                    studentProvider.updatelist(value);
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


              const SizedBox(height: 20), 
              Expanded(
                child: ListView.builder(
                  itemCount: studentProvider.filteredStudents.length,
                  itemBuilder: (context, index) {
                    final student = studentProvider.filteredStudents[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  StudentCoursesScreen(studentId: student.id,)));
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



