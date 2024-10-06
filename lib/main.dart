import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/features/authentication/login/login_teacher.dart';
import 'package:quran_tdress/navigation_menu_student.dart';
import 'package:quran_tdress/navigation_menu_teacher.dart';
import 'package:quran_tdress/provider/classprovider/add_progress_provider.dart';
import 'package:quran_tdress/provider/classprovider/attendence_provider.dart';
import 'package:quran_tdress/provider/classprovider/class_courses_provider.dart';
import 'package:quran_tdress/provider/classprovider/class_provider.dart';
import 'package:quran_tdress/provider/classprovider/class_students_provider.dart';
import 'package:quran_tdress/provider/classprovider/get_progress_provider.dart';
import 'package:quran_tdress/provider/classprovider/surah_provider.dart';
import 'package:quran_tdress/provider/studentprovider/student_courses_provider.dart';
import 'package:quran_tdress/provider/studentprovider/student_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp( MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (_) => ClassStudentsProvider()),
          ChangeNotifierProvider(create: (_) => StudentProvider()),
          ChangeNotifierProvider(create: (_) => ClassCourseProvider()),
          ChangeNotifierProvider(create: (_) =>AddProgressProvider()),
          ChangeNotifierProvider(create: (_) => ProgressProvider()),
          ChangeNotifierProvider(create: (_) => SurahProvider()),
          ChangeNotifierProvider(create: (_) => ClassRoomProvider()),
          ChangeNotifierProvider(create: (_) => StudentsProvider()),
          ChangeNotifierProvider(create: (_) => AttendanceProvider()),
      ],
      child: const App(),
    ),);
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLoginStatus(),
      builder: (context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading spinner
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            home: snapshot.data, // The initial screen (Login or Navigation)
          );
        }
      },
    );
  }

  Future<Widget> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final roleId = prefs.getInt('role_id');

    if (token != null && roleId != null) {
      // User is logged in, navigate to respective home screen
      if (roleId == 2 || roleId == 3) {
        return const NavigationMenuTeacher(); // Supervisor or Teacher
      } else if (roleId == 4) {
        return const NavigationMenuStudent(); // Student
      }
    }
    return const LoginScreen(); // If no token, show the login screen
  }
}





// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  const GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       // theme: TAppTheme.lightTheme,
//       // darkTheme: TAppTheme.darkTheme,
//       home: LoginScreen(),

      



//     );
//   }
// }



