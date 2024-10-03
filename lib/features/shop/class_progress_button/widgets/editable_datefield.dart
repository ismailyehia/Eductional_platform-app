import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class EditableDateField extends StatelessWidget {
  const EditableDateField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()), // Current date
    );

    return TextFormField(
      controller: _dateController, // Controller to handle the date
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(width: 1),
        ),
        labelText: "Enter or modify the date",
        prefixIcon: Icon(Iconsax.calendar),
        contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
      ),
    );
  }
}