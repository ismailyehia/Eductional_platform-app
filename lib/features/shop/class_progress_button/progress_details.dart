
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/features/shop/class_progress_button/add_progress.dart';
import 'package:quran_tdress/features/shop/class_progress_button/widgets/show_dialog_lesson.dart';
import 'package:quran_tdress/features/shop/class_progress_button/widgets/view_note.dart';
import 'package:quran_tdress/provider/classprovider/get_progress_provider.dart';

class ProgressDetails extends StatefulWidget {
  const ProgressDetails({super.key, required this.courseeid});

  final int courseeid;

  @override
  State<ProgressDetails> createState() => _ProgressDetailsState();
}

class _ProgressDetailsState extends State<ProgressDetails> {
  void initState() {
    super.initState();
    // Fetch progress data when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProgressProvider>(context, listen: false).fetchProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider =
        Provider.of<ProgressProvider>(context, listen: false);

    DateTime now = DateTime.now();
    String daydate = DateFormat('yyyy-MM-dd').format(now);
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Iconsax.arrow_circle_left),
        //   onPressed: () {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => const NavigationMenuTeacher()),
        //     );
        //   },
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Center(
          //     child: Text(
          //   classnamee,
          //   style: Theme.of(context).textTheme.headlineMedium,
          // )
          // ),

          // Center(
          //     child: Text(
          //   "",
          //   style: Theme.of(context).textTheme.headlineMedium,
          // )),
          const SizedBox(
            height: 20,
          ),

          //Date Filter
          TRoundedContainer(
            margin: const EdgeInsets.only(left: 35),
            width: 320,
            height: 60,
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.only(
              top: 15,
              left: 70,
            ),
            child: Text("Date ($daydate)",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),

          const SizedBox(
            height: 25,
          ),

          GestureDetector(
            onTap: () {
              final lessons = progressProvider.progressList
                  .map((progress) => progress.lesson
                      ?.name) // Use optional chaining to prevent null errors
                  .where((name) =>
                      name != null) // Filter out any null lesson names
                  .map((name) => name!) // Cast to non-nullable String
                  .toList();

              // Check if the lessons list is empty
              if (lessons.isEmpty) {
                print("No lessons available");
                return; // Optionally return if there are no lessons
              }

              // Show the dialog with the list of lesson names
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LessonDialog(
                      lessons: lessons); // Pass the list of lesson names
                },
              );
            },
            child: const TRoundedContainer(
              margin: EdgeInsets.only(left: 35),
              width: 320,
              height: 60,
              backgroundColor: Colors.purple,
              padding: EdgeInsets.only(
                top: 5,
                left: 120,
              ),
              child: Row(children: [
                Text("Lessons",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 70,
                ),
                Icon(
                  Iconsax.arrow_circle_down4,
                  size: 30,
                  color: Colors.white,
                )
              ]),
            ),
          ),

          const SizedBox(
            height: 35,
          ),

          GestureDetector(
            onTap: () {
              print(" course id :${widget.courseeid}");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AddProgressScreen(
                          courseid: widget.courseeid,
                        )),
              );
            },
            child: const TRoundedContainer(
              width: 400,
              height: 60,
              backgroundColor: Colors.black,
              padding: EdgeInsets.only(
                top: 15,
                left: 140,
              ),
              child: Text("Add Progress",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          const Text(
            "Progress :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),

          const SizedBox(
            height: 20,
          ),

          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Lesson name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                "Date",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                width: 55,
              ),
              Text(
                "Note",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              // IconButton(onPressed: (){}, icon:const Icon(Iconsax.eye)),
            ],
          ),

          Expanded(child: Consumer<ProgressProvider>(
              builder: (context, progressProvider, _) {
            if (progressProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (progressProvider.progressList.isEmpty) {
              return const Center(child: Text("No progress found."));
            }

            return ListView.builder(
              itemCount: progressProvider.progressList.length,
              itemBuilder: (context, index) {
                final progress = progressProvider.progressList[index];
                return Container(
                  height: 30,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          progress.lesson != null
                              ? " ${progress.lesson!.name}"
                              : "No Lesson",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          progress.date,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewNoteScreen(
                                        note: progress.note,
                                        date: progress.date,
                                        courseid: widget.courseeid,
                                      )),
                            );
                          },
                          icon: const Icon(Iconsax.eye)),
                    ],
                  ),
                );
              },
            );
          })),
        ]),
      ),
    );
  }
}
