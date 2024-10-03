
import 'package:flutter/material.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/provider/classprovider/class_provider.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/features/screens/home/progress_teacher_screen.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key,
  //  required int courseeid
   });

  @override
  Widget build(BuildContext context) {
    // Fetch the classes when the widget is first built
    Future.microtask(() =>
        Provider.of<ClassStudentsProvider>(context, listen: false)
            .fetchclasses());

    // final classprovider=  Provider.of<ClassStudentsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Classes'),
      ),
      body: Consumer<ClassStudentsProvider>(
        builder: (context, classProvider, child) {
          if (classProvider.isLoading) {
            // Show a loading spinner if data is still being fetched
            return const Center(child: CircularProgressIndicator());
          }

          if (classProvider.classes.isEmpty) {
            // Show a message if no classes are available
            return const Center(child: Text('No classes available'));
          }

          // Display the list of classes once the data is fetched
          return ListView.builder(
            itemCount: classProvider.classes.length,
            itemBuilder: (context, index) {
              final classStudent = classProvider.classes[index];
              return Column(
                children: [

                  const SizedBox(height: 40,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,MaterialPageRoute( builder: (context) => ProgressTeacher(classname: classStudent.name ,classid: classStudent.id)),
          );},
                    child: TRoundedContainer(
                                    width: 350,
                                    height: 60,
                                    padding: const EdgeInsets.only(top: 7,left: 130),
                                    backgroundColor: Colors.purple,
                                    child: Text(classStudent.name,style: const TextStyle(color: Colors.white, fontSize: 28,fontWeight: FontWeight.bold),),
                                  ),
                  ),

              const SizedBox(height: 15,),

                ],
              );
            },
          );
        },
      ),
    );
  }
}



