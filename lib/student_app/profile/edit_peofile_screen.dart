import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:quran_tdress/provider/students_app_provider/student_profile_provider.dart';
import 'package:quran_tdress/student_app/profile/profile_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:quran_tdress/provider/students_app_provider/student_profile_provider.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  EditProfileScreen(
      {super.key,
      required this.studentid,
      required this.name,
      required this.email,
      required this.birth,
      required this.country,
      required this.phone}) {
    namecontroller.text = name;
    emailcontroller.text = email;
    phonecontroller.text = phone;
    countrycontroller.text = country;
    birthcontroller.text = birth;
  }

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  TextEditingController birthcontroller = TextEditingController();

  TextEditingController countrycontroller = TextEditingController();

  final String name;
  final String email;
  final String birth;
  final String country;
  final String phone;
  final int studentid;
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
//   void initState() {
//   super.initState();
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     Provider.of<StudentProfileProvider>(context, listen: false).updateprofile();
//   });
// }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              const SizedBox(
                height: 3,
              ),

              TextFormField(
                  controller: widget.namecontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1)),
                    prefixIcon: Icon(Iconsax.personalcard),
                    labelText: "Name",
                    // contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                  )),

              const SizedBox(
                height: 8,
              ),

              const Text(
                "Email:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              const SizedBox(
                height: 3,
              ),

              TextFormField(
                  controller: widget.emailcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1)),
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: "Email",
                    // contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                  )),

              const SizedBox(
                height: 8,
              ),

              const Text(
                "Phone:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              const SizedBox(
                height: 3,
              ),

              TextFormField(
                  controller: widget.phonecontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1)),
                    prefixIcon: Icon(Iconsax.call),
                    labelText: "Phone",
                    // contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                  )),

              const SizedBox(
                height: 8,
              ),

              const Text(
                "birth date:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              const SizedBox(
                height: 3,
              ),

              TextFormField(
                  controller: widget.birthcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1)),
                    prefixIcon: Icon(Iconsax.document),
                    labelText: "yy-mm-dd",
                    // contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                  )),

              const SizedBox(
                height: 8,
              ),

              //     const Text("Sex :",style: TextStyle(
              //   fontWeight: FontWeight.bold,
              //   fontSize: 21,
              // ),),
              // const SizedBox(height: 3,),

              // TextFormField(
              //     controller: emailcontroller,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(16)),
              //           borderSide: BorderSide(width: 1)),
              //       prefixIcon: Icon(Iconsax.direct_right),
              //       labelText: "Email",
              //       // contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
              //     )),

              //     const SizedBox(height: 8,),

              const Text(
                "Country: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              const SizedBox(
                height: 3,
              ),

              TextFormField(
                  controller: widget.countrycontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1)),
                    prefixIcon: Icon(Iconsax.profile_circle1),
                    labelText: "Turkey..",
                    // contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                  )),

              const SizedBox(height: 20),

              // Save Button
              TRoundedContainer(
                margin: const EdgeInsets.only(left: 10),
                width: 300,
                height: 60,
                backgroundColor: const Color(0xFF7F56D9),
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 130,
                ),
                child: GestureDetector(
                  onTap: () {
                    String updatedname = widget.namecontroller.text;
                    String updatedemail = widget.emailcontroller.text;
                    String updatedcountry = widget.countrycontroller.text;
                    String updatedphone = widget.phonecontroller.text;
                    String updatedbirth = widget.birthcontroller.text;
                    Provider.of<StudentProfileProvider>(context, listen: false)
                        .updateprofile(
                            context: context,
                            id: widget.studentid,
                            name: updatedname,
                            email: updatedemail,
                            country: updatedcountry,
                            phone: updatedphone,
                            birth_date: updatedbirth,
                            )
                        .then((_) {
                      // Navigate back to ProgressDetails and reload the screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreenStudents(),
                        ),
                      );
                    });
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
              ),

              const SizedBox(
                height: 8,
              ),

              TRoundedContainer(
                margin: const EdgeInsets.only(left: 10, bottom: 10),
                showBorder: true,
                borderColor: const Color(0xFF475467),
                width: 300,
                height: 60,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 130,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProfileScreenStudents()));
                  },
                  child: const Row(
                    children: [
                      Text(
                        "Close",
                        style: TextStyle(
                            color: Colors.black,
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
    );
  }
}




