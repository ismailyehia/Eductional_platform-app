import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/features/shop/class_progress_button/widgets/show_dialog_lesson.dart';
import 'package:quran_tdress/features/shop/class_progress_button/widgets/view_note.dart';
import 'package:quran_tdress/provider/classprovider/add_progress_provider.dart';
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

  TextEditingController datecontroller = TextEditingController();
  TextEditingController scorecontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController lessoncontroller = TextEditingController();

  String? selectedLesson;
  bool isshown = false;
  bool isselected = true;

  @override
  Widget build(BuildContext context) {
    final progressProvider =
        Provider.of<ProgressProvider>(context, listen: false);

    datecontroller.text = DateTime.now().toString().substring(0, 10);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            const Text(
              "Date",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: datecontroller,
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

            const SizedBox(
              height: 25,
            ),

            const Text(
              "Select Lesson :",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(
              height: 6,
            ),

            GestureDetector(
              onTap: () {
                final lessons = progressProvider.progressList
                    .map((progress) => progress.lesson?.name)
                    .where((name) => name != null)
                    .map((name) => name!)
                    .toList();

                if (lessons.isEmpty) {
                  print("No lessons available");
                  return;
                }

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LessonDialog(
                      lessons: lessons,
                      onLessonSelected: (selectedLesson) {
                        setState(() {
                          this.selectedLesson = selectedLesson;
                        });
                      },
                    );
                  },
                );
              },
              child: TRoundedContainer(
                margin: const EdgeInsets.only(left: 8),
                width: 360,
                height: 60,
                backgroundColor: Color(0xFF7f56dD),
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 120,
                ),
                child: Row(children: [
                  Text(selectedLesson ?? "Lesson",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 70,
                  ),
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 30,
                    color: Colors.white,
                  )
                ]),
              ),
            ),

            SizedBox(
              height: 13,
            ),

            const Text(
              "Score",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: scorecontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(width: 1)),
                labelText: "Enter Score untill 10",
                prefixIcon: Icon(Iconsax.calendar),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 17, horizontal: 12),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isshown = !isshown;
                });
              },
              icon: Icon(
                isshown
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_forward_ios_rounded,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            isshown
                ? Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: notecontroller,
                        maxLines: null, 
                        expands:
                            true, 
                        decoration: const InputDecoration(
                          hintText: "Write Note here",
                          border: InputBorder.none, // Remove underline
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                : Container(),

            const SizedBox(
              height: 35,
            ),

            Consumer<AddProgressProvider>(
              builder: ( context, progressProvider, child) { 

              
              return GestureDetector(
                onTap: () {
                  print(" course id :${widget.courseeid}");
                  progressProvider.addProgress(
                          score: int.tryParse(scorecontroller.text),
                          courseId: widget.courseeid,
                          lessonId: int.tryParse(lessoncontroller.text) ?? 1,
                          suraId:
                              (from.text.isEmpty || to.text.isEmpty) ? null : 1,
                          note: notecontroller.text,
                          date: datecontroller.text,
                          from: from.text.isNotEmpty
                              ? int.tryParse(from.text)
                              : null, // Nullable
                          to: to.text.isNotEmpty ? int.tryParse(to.text) : null,
                          context: context,
                        );
                  TRoundedContainer(
                    width: 300,
                    height: 60,
                    backgroundColor: const Color(0xFF7F56D9),
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 160,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // final provider =Provider.of<AddProgressProvider>(context);
                        // print(" course id is ${widget.courseeid}");
                        
                      },
                      child: const Row(
                        children: [
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
              );
              },
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
                  width: 7,
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
              ],
            ),

            Divider(),
            SizedBox(
                height: 400,
                child: Consumer<ProgressProvider>(
                    builder: (context, progressProvider, _) {
                  if (progressProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (progressProvider.progressList.isEmpty) {
                    return const Center(child: Text("No progress found."));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
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
                                DateFormat('dd/MM/yy')
                                    .format(DateTime.parse(progress.date)),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              width: 28,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
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
      ),
    );
  }
}


