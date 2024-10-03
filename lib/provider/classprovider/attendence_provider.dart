// providers/attendance_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran_tdress/common/custom/custom_snackbar.dart';
import 'package:quran_tdress/features/screens/classes/classes_screen.dart';

import 'package:quran_tdress/models/student_attendence.dart';
import 'package:shared_preferences/shared_preferences.dart'; 


class AttendanceProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> saveAttendance(AttendanceModel attendance ,BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      throw Exception("No token found. Cannot authenticate.");
    }

    final response = await http.post(
      Uri.parse('https://quran.smartwork.com.tr/api/students/attendance/store'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(attendance.toJson()),
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Attendance saved successfully');
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar("Progress added successfully!"));
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ClassesScreen()), 
  );

    } else {
      // Handle error
      print('Failed to save attendance: ${response.body}');
    }

    _isLoading = false;
    notifyListeners();
  }
}
