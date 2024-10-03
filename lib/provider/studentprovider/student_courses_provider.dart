import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran_tdress/models/student_courses_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentsProvider extends ChangeNotifier {
  bool isLoading = false;
  Studentt? student;

  Future<void> fetchStudentData(int studentId) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://quran.smartwork.com.tr/api/students/$studentId');

    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        print("Error: No token found in SharedPreferences");
        return;
      }

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("Response data: ${response.body}");
  student = Studentt.fromJson(json.decode(response.body));
        print("Fetched student data: ${student?.name}");
      } else {
        print("Failed to fetch student data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error occurred: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}



