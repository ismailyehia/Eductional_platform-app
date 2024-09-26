import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quran_tdress/common/custom/custom_button.dart';
import 'package:quran_tdress/features/authentication/screens/signup/widgets/password_configurtion/forget_password.dart';
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

        // Role-based navigation
        // if (roleId == 1) {
        //   // Navigate to Admin page
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => AdminPage()), // Your Admin Page
        //   );
        // } else

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
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // Future<void> login(String email, String password) async {
  //   try {
  //     Map<String, String> headers = {
  //     "Accept": "aapplication/json",
  //     "Content-Type": "application/json"
  //     };
  //     Map<String, String> body = {
  //       "email": email,
  //       "password": password,
  //     };
  //     final response = await http.post(
  //       Uri.parse("https://quran.smartwork.com.tr/api/login"),
  //       headers: headers,
  //       body: jsonEncode(body),
  //     );

  //     print("Response status code: ${response.statusCode}");
  //     print("Response body: ${response.body}");

  //     if (response.statusCode == 200) {
  //       final dynamic tokenWithPrefix = response.body;
  //       final String token =
  //           tokenWithPrefix.substring(tokenWithPrefix.indexOf('|') + 1);

  //       final prefs = await SharedPreferences.getInstance();
  //       prefs.setString('token', token);

  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => NavigationMenu()),
  //       );
  //     } else {
  //       // Handle non-200 status code
  //       setState(() {
  //         errorMsg = "Invalid Email or Password";
  //       });

  //         ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Invalid Email or Password"),
  //         backgroundColor: Colors.red, // You can customize the color here
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //     }
  //   } catch (e) {
  //     setState(() {
  //       errorMsg = "An error occurred: $e";
  //     });
  //   }
  // }

  ///
  ///

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
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: TTexts.email,
            ),
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //password

          TextFormField(
            controller: passwordcontroller,
            // keyboardType: password,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              labelText: TTexts.password,
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),

          //
          const SizedBox(
            height: TSizes.spaceBtwInputFields / 2,
          ),
          //Remmber me & Forget password

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  const Text(TTexts.rememberMe),
                ],
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
            color: Colors.purple,
          ),

          // SizedBox(
          //     width: double.infinity,
          //     child: ElevatedButton(
          //       onPressed: () => Get.to(() => const NavigationMenu()),
          //       child: const Text(TTexts.signIn),
          //     )),
          // const SizedBox(
          //   height: TSizes.spaceBtwItems,
          // ),

          // CustomButton(text: "Create Account",func: () => Get.to(() => const SignUpScreen()),color: Colors.black, ),
          //Create Accuont Button
          // SizedBox(
          //     width: double.infinity,
          //     child: OutlinedButton(
          //       onPressed: () => Get.to(() => const SignUpScreen()),
          //       child: const Text(TTexts.createAccount),
          //     )),
        ],
      ),
    ));
  }
}
