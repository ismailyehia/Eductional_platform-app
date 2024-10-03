
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran_tdress/models/student_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProvider with ChangeNotifier {
  List<Student> _students = [];
  bool isLoading = false;

  List<Student> get students => _students;

  Future<void> fetchStudents() async {
    isLoading = true;
    notifyListeners();

    try {
      const String url = "https://quran.smartwork.com.tr/api/teachers/students";

      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        print("Error: No token found in SharedPreferences");
        return;
      }

      // Make the request to fetch students
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);

        _students = jsonData.map((item) => Student.fromJson(item)).toList();
        notifyListeners();
      } else {
        print("Error: Failed to load students. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching students: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}