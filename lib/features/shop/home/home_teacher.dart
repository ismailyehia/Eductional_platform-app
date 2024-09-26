import 'package:flutter/material.dart';
import 'package:quran_tdress/common/custom/custom_button.dart';
import 'package:quran_tdress/features/shop/attendence_button/attendence_button.dart';

class HomeScreenTeacher extends StatelessWidget {
  const HomeScreenTeacher({super.key, required this.classname, });

  final String classname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              classname,
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
                        builder: (context) =>
                             AttendenceButton(classnamee: classname,)), // Your Supervisor Page
                  );
                }),
            SizedBox(
              height: 32,
            ),
            const CustomButton(text: "Class Progress", color: Colors.purple),
          ],
        ),
      ),
    );
  }
}
