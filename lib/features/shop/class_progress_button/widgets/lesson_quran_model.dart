// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class Surahs {
//   final int id;
//   final int number;
//   final String nameAr;
//   final String nameEn;
//   final String type;

//   Surahs({
//     required this.id,
//     required this.number,
//     required this.nameAr,
//     required this.nameEn,
//     required this.type,
//   });

//   factory Surahs.fromJson(Map<String, dynamic> json) {
//     return Surahs(
//       id: json['id'],
//       number: json['number'],
//       nameAr: json['name_ar'],
//       nameEn: json['name_en'],
//       type: json['type'],
//     );
//   }
// }



// Future<List<Surahs>> fetchSurahs() async {
//   final response = await http.get(Uri.parse('https://quran.smartwork.com.tr/api/surahs'));

//   if (response.statusCode == 200) {
//     List jsonResponse = json.decode(response.body);
//     return jsonResponse.map((surah) => Surahs.fromJson(surah)).toList();
//   } else {
//     throw Exception('Failed to load Surahs');
//   }
// }



