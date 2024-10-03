import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran_tdress/models/class_students_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ClassRoomProvider extends ChangeNotifier {
  bool isLoading = false;
  ClassRoom? classRoom;

  Future<void> fetchClassRoomData(int classRoomId) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://quran.smartwork.com.tr/api/teachers/classes/$classRoomId');

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
        final Map<String, dynamic> data = json.decode(response.body);
        classRoom = ClassRoom.fromJson(data);
        print("Fetched class room data: ${classRoom?.name}");
      } else {
        print("Failed to fetch class room data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error occurred: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }





}



