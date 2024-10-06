import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran_tdress/common/custom/custom_snackbar.dart';
import 'package:quran_tdress/features/shop/class_progress_button/progress_details.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Lesson {
  final int id;
  final String name;

  Lesson({
    required this.id,
    required this.name,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class AddProgressProvider extends ChangeNotifier {
  bool isLoading = false;

  

  Future<void> addProgress({
    required BuildContext context, 
    required int courseId,
    required int lessonId,
    required int? suraId,
    required String? note,
    required String? date,
    required int? from,
    required int? to,
  }) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        'https://quran.smartwork.com.tr/api/classRooms/1/courses/1/progresses');

    // Construct the body
    final body = jsonEncode({
      "course_id": courseId,
      "lesson_id": lessonId,
      "sura_id": suraId,
      "note": note,
      "class_room_id": "1", 
      "date": date,
      "from": from,
      "to": to
    });

    try {
      print("Sending the following data to the API:");
      print("Body: $body");

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token'); // Fetch the token

      if (token == null) {
        print("Error: No token found in SharedPreferences");
        return;
      }
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', 
        },
        body: body,
      );

      if (response.statusCode == 201) {
        
        final responseData = json.decode(response.body);
        // Handle success (e.g., show a toast or navigate)
        print("Created Successfully: ${responseData['message']}");
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar("Progress added successfully!"));
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ProgressDetails(courseeid: 0,)), // Update with the actual parameters if needed
  );
      } else {
        // Handle failure (e.g., show an error message)
        print("Failed to create progress: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } catch (error) {
      print("Error occurred: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}


