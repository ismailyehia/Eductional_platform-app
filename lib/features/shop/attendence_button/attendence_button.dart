import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/navigation_menu_teacher.dart';

class AttendenceButton extends StatelessWidget {
  const AttendenceButton({super.key, required this.classnamee});

  final String classnamee;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String daydate = DateFormat('yyyy-MM-dd').format(now);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const NavigationMenuTeacher()),
              icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Center(
                child: Text(
              classnamee,
              style: Theme.of(context).textTheme.headlineMedium,
            )),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "Attendence Sheet",
              style: Theme.of(context).textTheme.headlineMedium,
            )),
            const SizedBox(
              height: 25,
            ),

            //Date Filter
            TRoundedContainer(
              width: 320,
              height: 60,
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.only(
                top: 15,
                left: 40,
              ),
              child: Text("Date Filter  ($daydate)",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 30,
            ),

            //Mark Students
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const TRoundedContainer(
                    width: 190,
                    height: 70,
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.only(
                      top: 6,
                      left: 30,
                    ),
                    child: Text("Mark All as a Present",
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
                  onTap: () {},
                  child: const TRoundedContainer(
                    width: 190,
                    height: 70,
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.only(
                      top: 6,
                      left: 30,
                    ),
                    child: Text("Mark All as a Absent",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
