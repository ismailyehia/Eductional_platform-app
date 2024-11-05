import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quran_tdress/common/custom/custom_snackbar.dart';
import 'package:quran_tdress/models/student_models/studentprofile_app_model.dart';
import 'package:http/http.dart' as http;
import 'package:quran_tdress/student_app/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfileProvider extends ChangeNotifier {
  List<User> _user = [];
  List<User> get user => _user;

  bool isLoading = false;

  Future<void> fetchprofile() async {
    isLoading = true;
    try {
      const String url = "https://quran.smartwork.com.tr/api/profile";

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token'); // Fetch the token

      if (token == null) {
        print("Error: No token found in SharedPreferences");
        return;
      }

      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsondata = jsonDecode(response.body);

        final userData = jsondata['user'];
        if (userData != null) {
          _user = [User.fromJson(userData)];
        } else {
          print("Error: 'user' key not found in the response JSON");
        }
        notifyListeners();
      } else {
        print("Failed to fetch profile data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching profile data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateprofile({
    required BuildContext context,
    required int id,
    required String name,
    required String email,
    final String? birth_date,
    final String? country,
    final String? phone,
    final String? sex,
    // final String profile_photo_url,
    final int? age,
  }) async {
    const String url = "https://quran.smartwork.com.tr/api/profile/update";

    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        return;
      }
      final body = json.encode({
        'name': name,
        'email': email,
        'birth_date': birth_date,
        'country': country,
        'phone': phone,
        'sex': sex,
        // 'profile_photo_url': profile_photo_url,
        'age': age,
      });
      final response = await http.put(Uri.parse(url), body: body, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar("profile information Updated Successfully!"));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ProfileScreenStudents()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar( customSnackBar("Failed to update profile information"));
        print("Failed to update : ${response.body}");
        print("Failed to update note: ${response.statusCode}");
      }
    } catch (e) {
      print("Error updating profile data: $e");
    }
  }
}


