import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    color: Colors.purple,
                    height: 40,
                    width: 240,
                    padding: EdgeInsets.only(left: 90,top: 7),
                    child: Text("Teacher", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23
                    )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    color: Colors.purple,
                    height: 40,
                    width: 240,
                    padding: EdgeInsets.only(left: 90,top: 7),
                    child: Text("Student", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23
                    )),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
