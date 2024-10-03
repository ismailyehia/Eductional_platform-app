
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quran_tdress/models/class_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SurahProvider extends ChangeNotifier {
  List<Surah> _surahList = [];
  bool isLoading = false;

  List<Surah> get surahList => _surahList;

  Future<void> fetchSurahList() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://your-backend-url/api/surah'); // Update with your actual API

    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _surahList = data.map((json) => Surah.fromJson(json)).toList();
      } else {
        print("Failed to fetch Surah list");
      }
    } catch (error) {
      print("Error occurred: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}


