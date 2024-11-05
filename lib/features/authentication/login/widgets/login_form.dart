import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quran_tdress/common/custom/custom_button.dart';
import 'package:quran_tdress/features/screens/signup/widgets/password_configurtion/forget_password.dart';
import 'package:quran_tdress/navigation_menu_student.dart';
import 'package:quran_tdress/navigation_menu_teacher.dart';
import 'package:quran_tdress/utils/constants/sizes.dart';
import 'package:quran_tdress/utils/constants/text_strings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TLoinForm extends StatefulWidget {
  const TLoinForm({
    super.key,
  });

  @override
  State<TLoinForm> createState() => _TLoinFormState();
}

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();

class _TLoinFormState extends State<TLoinForm> {
  late String? errorMsg;
  bool _isPasswordVisible = false; 

  //Login Function

  Future<void> login(String email, String password) async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json"
      };
      Map<String, String> body = {
        "email": email,
        "password": password,
      };
      final response = await http.post(
        Uri.parse("https://quran.smartwork.com.tr/api/login"),
        headers: headers,
        body: jsonEncode(body),
      );

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        // Assuming the response contains a token and a role_id
        final String token = responseBody['token'];
        final int roleId = responseBody['role_id'];

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        print("user Token is $token");
        prefs.setInt('role_id', roleId);

        if (roleId == 2) {
          // Navigate to Supervisor page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const NavigationMenuTeacher()), // Your Supervisor Page
          );
        } else if (roleId == 3) {
          // Navigate to Teacher page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const NavigationMenuTeacher()), // Your Teacher Page
          );
        } else if (roleId == 4) {
          // Navigate to Student page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const NavigationMenuStudent()), // Your Student Page
          );
        } else {
          // If role_id is invalid or not found
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid Role"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        // Handle non-200 status code
        setState(() {
          errorMsg = "Invalid Email or Password";
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Email or Password"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      setState(() {
        errorMsg = "An error occurred: $e";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Column(
        children: [
          //email

          TextFormField(
              controller: emailcontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(width: 1)),
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
                // contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 12),
              )),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //password

          TextFormField(
              controller: passwordcontroller,
              obscureText: !_isPasswordVisible,
              decoration:  InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(width: 1),
                ),
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon:    IconButton( icon: Icon(_isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash ),
                onPressed: (){

                  setState(() {
                      _isPasswordVisible = !_isPasswordVisible; 
                  });

                }

                ),
              )),

          //
          const SizedBox(
            height: TSizes.spaceBtwInputFields / 2,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 200,
              ),

              //forget password

              TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(TTexts.forgetPassword)),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          //Sign In Button

          CustomButton(
            text: "Sign In",
            func: () {
              final email = emailcontroller.text;
              final password = passwordcontroller.text;
              login(email, password);
            },
            txtcolors: Colors.white,
            txtcolor: Colors.purple,
          ),
        ],
      ),
    ));
  }
}
