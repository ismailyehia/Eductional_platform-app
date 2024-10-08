// import 'package:flutter/material.dart';
// import 'package:quran_tdress/models/student_courses_model.dart';
// import 'package:table_calendar/table_calendar.dart';

// class DateCalender extends StatefulWidget {
//   const DateCalender({super.key,
//    required this.attendances, 
//     // required this.hasattended
//     });

//   final List<Attendance>
//       attendances; // Assuming AttendanceModel contains 'date' and 'hasAttended'
//   // final int hasattended;
//   @override
//   _DateCalenderState createState() => _DateCalenderState();
// }

// class _DateCalenderState extends State<DateCalender> {
//   late final ValueNotifier<DateTime> _selectedDay;
//   late final ValueNotifier<DateTime> _focusedDay;
//   late final Map<DateTime, int> attendanceMap; // Map to store attendance data

//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = ValueNotifier(DateTime.now());
//     _focusedDay = ValueNotifier(DateTime.now());

//     // Create the attendance map from the attendance data
//     attendanceMap = {
//       for (var attendance in widget.attendances)
//         DateTime.parse(attendance.date): attendance.hasAttended
//     };
//   }

//   @override
//   void dispose() {
//     _selectedDay.dispose();
//     _focusedDay.dispose();
//     super.dispose();
//   }

//   Color getAttendanceColor(DateTime day) {
//     // Return color based on attendance status
//     if (attendanceMap[day] == 1) {
//       return Colors.green; // Attended
//     } else if (attendanceMap[day] == 0) {
//       return Colors.red; // Not attended
//     }
//     return Colors.transparent; // No attendance data
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Calendar'),
//       ),
//       body: Column(
//         children: [
//           TableCalendar<DateTime>(
//             firstDay: DateTime.utc(2020, 1, 1),
//             lastDay: DateTime.utc(2030, 12, 31),
//             focusedDay: _focusedDay.value,
//             selectedDayPredicate: (day) {
//               return isSameDay(_selectedDay.value, day);
//             },
//             onDaySelected: (selectedDay, focusedDay) {
//               _selectedDay.value = selectedDay;
//               _focusedDay.value = focusedDay;
//             },
//             onPageChanged: (focusedDay) {
//               _focusedDay.value = focusedDay;
//             },
//             calendarBuilders: CalendarBuilders(
//               // Customizing day cells
//               defaultBuilder: (context, day, focusedDay) {
//                 final color = getAttendanceColor(day);
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: color,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(child: Text('${day.day}')),
//                 );
//               },
//               todayBuilder: (context, day, focusedDay) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(child: Text('${day.day}')),
//                 );
//               },
//               selectedBuilder: (context, day, focusedDay) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(child: Text('${day.day}')),
//                 );
//               },
//             ),
//           ),
//           // Display selected date
//           ValueListenableBuilder<DateTime>(
//             valueListenable: _selectedDay,
//             builder: (context, value, _) {
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Selected Date: ${value.toLocal()}'.split(' ')[0],
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'package:quran_tdress/models/student_courses_model.dart';
import 'package:table_calendar/table_calendar.dart';

class DateCalender extends StatefulWidget {
  const DateCalender({super.key, required this.attendances});

  final List<Attendance> attendances;

  @override
  _DateCalenderState createState() => _DateCalenderState();
}

class _DateCalenderState extends State<DateCalender> {
  late final ValueNotifier<DateTime> _selectedDay;
  late final ValueNotifier<DateTime> _focusedDay;
  late final Map<DateTime, int> attendanceMap; // Map to store attendance data

  @override
  void initState() {
    super.initState();
    _selectedDay = ValueNotifier(DateTime.now());
    _focusedDay = ValueNotifier(DateTime.now());

    // Create the attendance map from the attendance data
    attendanceMap = {
      for (var attendance in widget.attendances)
        DateTime.parse(attendance.date): attendance.hasAttended
    };
  }

  @override
  void dispose() {
    _selectedDay.dispose();
    _focusedDay.dispose();
    super.dispose();
  }

  Color getAttendanceColor(DateTime day) {
    // Return color based on attendance status
    if (attendanceMap[day] == 1) {
      return Colors.green; // Attended
    } else if (attendanceMap[day] == 0) {
      return Colors.red; // Not attended
    }
    return Colors.transparent; // No attendance data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar<DateTime>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay.value,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                _selectedDay.value = selectedDay;
                _focusedDay.value = focusedDay;
              },
              onPageChanged: (focusedDay) {
                _focusedDay.value = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                // Customizing day cells
                defaultBuilder: (context, day, focusedDay) {
                  final color = getAttendanceColor(day);
                  return Container(
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text('${day.day}')),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text('${day.day}')),
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text('${day.day}')),
                  );
                },
              ),
            ),
            // Display selected date
            ValueListenableBuilder<DateTime>(
              valueListenable: _selectedDay,
              builder: (context, value, _) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Selected Date: ${value.toLocal()}'.split(' ')[0],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

