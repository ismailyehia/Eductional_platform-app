import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/features/authentication/controllers/class_provider.dart';
import 'package:quran_tdress/features/authentication/screens/login/login_teacher.dart';

void main() {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClassStudentsProvider()),
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

