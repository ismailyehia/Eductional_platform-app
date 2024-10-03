import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quran_tdress/models/class_courses_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassCourseProvider with ChangeNotifier {
  ClassModel? _classModel;

  ClassModel? get classModel => _classModel;

  bool isLoading = false;




Future<void> fetchClassData(int id) async {
  isLoading = true;
  notifyListeners(); // Notify listeners when fetching starts
  try {
    String url = "https://quran.smartwork.com.tr/api/classRooms/$id";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      throw Exception("No token found. Cannot authenticate.");
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token', 
        'Accept': 'application/json',
      },
    );

    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      _classModel = ClassModel.fromJson(jsonData);
    } else {
      print("Error: Failed to load class data with status code ${response.statusCode}");
      print("Error body: ${response.body}");
      throw Exception('Failed to load class data');
    }
  } catch (e, stackTrace) {
    print("Error fetching class data: $e");
    print("Stack trace: $stackTrace");
  } finally {
    isLoading = false;
    notifyListeners(); // Notify listeners when fetching ends
  }
}















}




