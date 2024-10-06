
import 'package:flutter/material.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/features/authentication/login/login_teacher.dart';
import 'package:quran_tdress/provider/classprovider/class_provider.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/features/screens/home/progress_teacher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

        drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // UserAccountsDrawerHeader(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage("assets/batman.jpg"), fit: BoxFit.cover),
              //   ),
              //   currentAccountPicture: CircleAvatar(
              //       radius: 55, backgroundImage: AssetImage("assets/5.jpg")),
              //   accountEmail: Text("  ${userModel.email}"),
              //   accountName: Text(
              //     " ",
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              
              const SizedBox(height: 33,),
              
              ListTile(
                  title: const Text("About"),
                  leading: const Icon(Icons.help_center),
                  onTap: () {}),
        
                  ListTile(
                  title: const Text("Dark/light mode"),
                  leading: const Icon(Icons.help_center),
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DarkModeScreen(),
                    //   ),
                    // );
                  }),
              ListTile(
                  title: const Text("Logout"),
                  leading: const Icon(Icons.exit_to_app),
                  onTap: () async{
                    
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('token');
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
        
                  }),
              Container(
                margin: const EdgeInsets.only(top: 260),
                child: const Text("Developed by ISMAIL YEHIA © 2024",
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
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

          return ListView.builder(
            itemCount: classProvider.classes.length,
            itemBuilder: (context, index) {
              final classStudent = classProvider.classes[index];
              return Column(
                children: [

                  const SizedBox(height: 40,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute( builder: (context) => ProgressTeacher(classname: classStudent.name ,classid: classStudent.id)),
          );},
                    child: TRoundedContainer(
                                    width: 350,
                                    height: 60,
                                    padding: const EdgeInsets.only(top: 7,left: 130),
                                    backgroundColor: const Color(0xFF7F56D9),
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



