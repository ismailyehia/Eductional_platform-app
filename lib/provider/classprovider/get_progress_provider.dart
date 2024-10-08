import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran_tdress/common/custom/custom_snackbar.dart';
import 'package:quran_tdress/features/shop/class_progress_button/progress_details.dart';
import 'package:quran_tdress/models/class_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProgressProvider extends ChangeNotifier {
  List<Progressget> _progressList = [];
  bool isLoading = false;

  List<Progressget> get progressList => _progressList;

Future<void> fetchProgress() async {
  isLoading = true;
  notifyListeners();

  final url = Uri.parse('https://quran.smartwork.com.tr/api/students/5/courses/1/progresses');

  try {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Fetch the token

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

    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      // final List<dynamic> data = json.decode(response.body); 
      

        final Map<String, dynamic> responseData = json.decode(response.body);
      
      final List<dynamic> data = responseData['progress'];

      
      if (data.isEmpty) {
        print("No progress entries found in the response.");
        _progressList = []; 
        return;
      }

      
      _progressList = data.map((progressJson) => Progressget.fromJson(progressJson)).toList();
      
      
      print("Parsed progress list: $_progressList");
    } else {
      print("Failed to fetch progress: ${response.statusCode}");
    }
  } catch (error) {
    print("Error occurred: $error");
  } finally {
    isLoading = false;
    notifyListeners();
  }
}









  List<Surah> _surahList = [];
  List<int> fromList = []; // List for `from` values
  List<int> toList = [];   // List for `to` values

  List<Surah> get surahList => _surahList;














Future<void> updateProgressNote({
  required String updatedNote,
  required BuildContext context, 
  required int courseId,
  required String date, 
}) async {
  final url = Uri.parse(
      'https://quran.smartwork.com.tr/api/classRooms/1/courses/1/progresses/1'); 

  try {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Fetch the token

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      return;
    }

    // Send the PUT request to update the note
    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', 
      },
      body: json.encode({
        'note': updatedNote, 
        'date': date,
        'course_id': courseId,  
      }),
    );

    print("Update Response status code: ${response.statusCode}");
    print("Update Response body: ${response.body}");

    if (response.statusCode == 200) {
      print("Note updated successfully");
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar("Credentails Updated Successfully"));
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ProgressDetails(courseeid: 0,)),
  );
    } else {
      print("Failed to update note: ${response.statusCode}");
    }
  } catch (error) {
    print("Error occurred while updating note: $error");
  } finally {
    notifyListeners(); 
  }
}



}













