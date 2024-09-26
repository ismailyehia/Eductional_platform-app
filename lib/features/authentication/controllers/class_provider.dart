import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quran_tdress/features/authentication/models/class_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassStudentsProvider with ChangeNotifier {
  List<ClassStudents> _classes = [];

  List<ClassStudents> get classes => _classes;

  bool isLoading = false;

  Future<void> fetchclasses() async {
    isLoading = true;
    try {
      
      const String url = "https://quran.smartwork.com.tr/api/teachers/classes";
      

      //token from shared
      final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Fetch the token

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      return;
    }

      final response = await http.get(Uri.parse(url),
       headers: {
    'Authorization': 'Bearer $token', 
    'Accept': 'application/json',
  },
      );

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);

        _classes =
            jsonData.map((item) => ClassStudents.fromJson(item)).toList();
        notifyListeners();
      } else {
        print("Error: Failed to load classes with status code: ${response.statusCode}");
      print("Error body: ${response.body}");
        throw Exception("Faield to Load classes");
      }
    } catch (e) {
      print("error fetching classes $e");
    }
    isLoading = false;
    notifyListeners(); 
  }
}




