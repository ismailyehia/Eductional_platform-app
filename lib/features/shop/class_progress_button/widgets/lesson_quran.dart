
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:quran_tdress/common/custom/rounded_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Surahs {
  final int id;
  final int number;
  final String nameAr;
  final String nameEn;
  final String type;

  Surahs({
    required this.id,
    required this.number,
    required this.nameAr,
    required this.nameEn,
    required this.type,
  });

  factory Surahs.fromJson(Map<String, dynamic> json) {
    return Surahs(
      id: json['id'],
      number: json['number'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      type: json['type'],
    );
  }
}

Future<List<Surahs>> fetchSurahs() async {
  final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print("Error: No token found in SharedPreferences");
      throw Exception("No token found. Cannot authenticate.");
    }

  final response = await http.get(Uri.parse('https://quran.smartwork.com.tr/api/surahs'),headers: {
        'Authorization': 'Bearer $token', 
        'Accept': 'application/json',
      },);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((surah) => Surahs.fromJson(surah)).toList();
  } else {
    // Log more details about the error
    print('Failed to load Surahs: Status Code ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load Surahs');
  }
}

class SurahDropdown extends StatefulWidget {
  @override
  _SurahDropdownState createState() => _SurahDropdownState();
}

class _SurahDropdownState extends State<SurahDropdown> {
  List<Surahs> _surahList = [];
  Surahs? _selectedSurah;
  int? _fromNumber;
  int? _toNumber;

  @override
  void initState() {
    super.initState();
    _getSurahList();
  }

  Future<void> _getSurahList() async {
    try {
      List<Surahs> surahs = await fetchSurahs();
      setState(() {
        _surahList = surahs;
      });
    } catch (e) {
      print('Failed to load surahs: $e');
    }
  }

   List<int> _getNumberList() {
    return List<int>.generate(500, (i) => i + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Wrap with Scaffold
      appBar: AppBar(title: const Text('Surah Dropdown')), // Optional: Adds an AppBar
      body: Column(
        children: [ 
          const SizedBox(width: 33,),
          Row(
            children: [Expanded(
              child: TRoundedContainer(
                  margin: const EdgeInsets.only(left: 2,top: 38),
                  width: 200,
                  height: 60,
                  backgroundColor: const Color.fromARGB(255, 2, 127, 230),
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 120,
                  ),
                child: DropdownButton<Surahs>(
                        hint: const Text('Select Surah'),
                        value: _selectedSurah,
                        onChanged: (Surahs? newValue) {
                setState(() {
                  _selectedSurah = newValue;
                });
                        },
                        items: _surahList.map((Surahs surah) {
                return DropdownMenuItem<Surahs>(
                  value: surah,
                  child: Text('${surah.nameAr} - ${surah.nameEn}'),
                );
                        }).toList(),
                      ),
              ),
            ),
            ]
          ),


          const SizedBox(height: 40,),

              Row(
            children: [
              Expanded(
                child: TRoundedContainer(
                  height: 60,
                  backgroundColor: const Color.fromARGB(255, 2, 127, 230),
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 50,
                  ),
                  child: DropdownButton<int>(
                    hint: const Text('From', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    value: _fromNumber,
                    onChanged: (int? newValue) {
                      setState(() {
                        _fromNumber = newValue;
                      });
                    },
                    items: _getNumberList().map((int number) {
                      return DropdownMenuItem<int>(
                        value: number,
                        child: Text(number.toString(), style: const TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    icon: const Icon(Iconsax.arrow_circle_down4, color: Colors.white),
                    dropdownColor: Colors.white,
                  ),
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: TRoundedContainer(
                  height: 60,
                  backgroundColor: const Color.fromARGB(255, 2, 127, 230),
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 50,
                  ),
                  child: DropdownButton<int>(
                    hint: const Text('To', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    value: _toNumber,
                    onChanged: (int? newValue) {
                      setState(() {
                        _toNumber = newValue;
                      });
                    },
                    items: _getNumberList().map((int number) {
                      return DropdownMenuItem<int>(
                        value: number,
                        child: Text(number.toString(), style: const TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    icon: const Icon(Iconsax.arrow_circle_down4, color: Colors.white),
                    dropdownColor:  Colors.white,
                  ),
                ),
              ),
            ],
          ),
  

      ]
      )
    );
  }
}































// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:quran_tdress/common/custom/rounded_container.dart';

// class LessonQuranScreen extends StatelessWidget {
//   const LessonQuranScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: const Column(
        
//         children: [
//           // Center(
//           //   child: Text(
//           //     "Quran Lessons",
//           //     style: TextStyle(
//           //       fontSize: 24,
//           //       fontWeight: FontWeight.bold,
//           //     ),
//           //   ),
//           // ),
//           SizedBox(
//             height: 20,
//           ),

//           TRoundedContainer(
//               margin: EdgeInsets.only(left: 35),
//               width: 300,
//               height: 60,
//               backgroundColor: Colors.purple,
//               padding: EdgeInsets.only(
//                 top: 5,
//                 left: 120,
//               ),
//               child: Row(children: [
//                 Text("Surah",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold)),
//                 SizedBox(
//                   width: 70,
//                 ),
//                 Icon(
//                   Iconsax.arrow_circle_down4,
//                   size: 30,
//                   color: Colors.white,
//                 ),
//               ]),
//             ),



//             SizedBox(height: 40,),


//             Row(
//   children: [
//     Expanded(
//       child: TRoundedContainer(
//         width: 150, // This will be ignored by Expanded
//         height: 60,
//         backgroundColor: Colors.purple,
//         padding: EdgeInsets.only(
//           top: 5,
//           left: 50,
//         ),
//         child: Row(
//           children: [
//             Text(
//               "From",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Spacer(), // To push the icon to the right
//             Icon(
//               Iconsax.arrow_circle_down4,
//               size: 30,
//               color: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     ),

//     SizedBox(width: 20),

//     Expanded(
//       child: TRoundedContainer(
//         width: 150, // This will be ignored by Expanded
//         height: 60,
//         backgroundColor: Colors.purple,
//         padding: EdgeInsets.only(
//           top: 5,
//           left: 50,
//         ),
//         child: Row(
//           children: [
//             Text(
//               "To",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Spacer(), // To push the icon to the right
//             Icon(
//               Iconsax.arrow_circle_down4,
//               size: 30,
//               color: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     ),
//   ],
// )

            
//         ],
//       ),
//     );
//   }
// }


