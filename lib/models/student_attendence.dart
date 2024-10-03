// models/attendance_model.dart

class AttendanceModel {
  final List<StudentAttendance> students;
  final String date;

  AttendanceModel({required this.students, required this.date});

  Map<String, dynamic> toJson() {
    return {
      'students': students.map((student) => student.toJson()).toList(),
      'date': date,
    };
  }
}

class StudentAttendance {
  final int userId;
  final bool hasAttended;

  StudentAttendance({required this.userId, required this.hasAttended});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'has_attended': hasAttended,
    };
  }
}
