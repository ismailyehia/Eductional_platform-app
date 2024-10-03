import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/features/shop/class_progress_button/progress_details.dart';
import 'package:quran_tdress/provider/classprovider/add_progress_provider.dart';

class AddProgressScreen extends StatelessWidget {
  const AddProgressScreen({super.key, required this.courseid});

  final int courseid;

  @override
  Widget build(BuildContext context) {
    TextEditingController lessonnumber = TextEditingController();
    TextEditingController note = TextEditingController();
    TextEditingController from = TextEditingController();
    TextEditingController to = TextEditingController();
    TextEditingController dateController = TextEditingController();

    // Example: Set current date as initial value for date field
    dateController.text = DateTime.now().toString().substring(0, 10);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AddProgressProvider>(
            builder: (context, provider, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Add Lesson Number",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                TextFormField(
                  controller: lessonnumber,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1)),
                    labelText: "(1,2,3....)",
                    prefixIcon: Icon(Iconsax.note),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Date",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: dateController, // User can edit the date
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1)),
                    labelText: "Enter date",
                    prefixIcon: Icon(Iconsax.calendar),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  "From (for Quran Course just)",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                TextFormField(
                  controller: from,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1)),
                    labelText: "(1,2,3....)",
                    prefixIcon: Icon(Iconsax.add),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  "To (for Quran Course just)",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                TextFormField(
                  controller: to,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1)),
                    labelText: "(1,2,3....)",
                    prefixIcon: Icon(Iconsax.add),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Add Note",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: note,
                      maxLines: null, // Allow multiple lines
                      expands:
                          true, // TextFormField takes the full container height
                      decoration: const InputDecoration(
                        hintText: "Write Note here",
                        border: InputBorder.none, // Remove underline
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Save Button
                TRoundedContainer(
                  width: 300,
                  height: 60,
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 160,
                  ),
                  child: InkWell(
                    onTap: () {


                      provider.addProgress(
                        courseId: courseid,
                        lessonId: int.tryParse(lessonnumber.text) ?? 1, 
                        suraId: (from.text.isEmpty || to.text.isEmpty)? null: 1,
                        note: note.text,
                        date: dateController.text,
                        from: from.text.isNotEmpty
                            ? int.tryParse(from.text)
                            : null, // Nullable
                        to: to.text.isNotEmpty
                            ? int.tryParse(to.text)
                            : null, context: context, // Nullable
                      ); },
                      child: const Row( children: [
                        Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TRoundedContainer(
                  width: 300,
                  height: 60,
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 160,
                  ),
                  child: InkWell(
                    onTap: (){
                      
          
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const   ProgressDetails(courseeid: 0)));
          
         
                    },
                    child: const Row(
                      children: [
                        Text(
                          "Close",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


