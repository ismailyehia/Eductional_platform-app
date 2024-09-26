import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.func, required this.color});

  final String text;
  final void Function()? func;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        onPressed: func,
        child: Text(
          text,
          style: TextStyle(color: Colors.white,fontSize: 19),
        ),
      ),
    );
  }
}
