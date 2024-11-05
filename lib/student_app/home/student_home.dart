import 'package:flutter/material.dart';
import 'package:quran_tdress/features/authentication/login/login_teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentsHome extends StatelessWidget {
  const StudentsHome({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: Text("Home Screen"),
      ),
    );
  }
}