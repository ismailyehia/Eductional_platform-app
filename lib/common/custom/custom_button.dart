import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.text, this.func, this.txtcolor = Colors.purple,  this.txtcolors = Colors.white});

  final String text;
  final Color txtcolors;
  final void Function()? func;
  final Color txtcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(txtcolor),
        ),
        onPressed: func,
        child: Text(
          text,
          style: TextStyle(color: txtcolors, fontSize: 19),
        ),
      ),
    );
  }
}
