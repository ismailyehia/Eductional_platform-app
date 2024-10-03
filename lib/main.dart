import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/features/authentication/login/login_teacher.dart';
import 'package:quran_tdress/provider/classprovider/add_progress_provider.dart';
import 'package:quran_tdress/provider/classprovider/attendence_provider.dart';
import 'package:quran_tdress/provider/classprovider/class_courses_provider.dart';
import 'package:quran_tdress/provider/classprovider/class_provider.dart';
import 'package:quran_tdress/provider/classprovider/class_students_provider.dart';
import 'package:quran_tdress/provider/classprovider/get_progress_provider.dart';
import 'package:quran_tdress/provider/classprovider/surah_provider.dart';
import 'package:quran_tdress/provider/studentprovider/student_courses_provider.dart';
import 'package:quran_tdress/provider/studentprovider/student_provider.dart';


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
    return  const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      // theme: TAppTheme.lightTheme,
      // darkTheme: TAppTheme.darkTheme,
      home: LoginScreen(),

      



    );
  }
}

