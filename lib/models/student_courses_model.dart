// Course Model
class Course {
  final int id;
  final String name;
  final String type;
  final int progress;

  Course({
    required this.id,
    required this.name,
    required this.type,
    required this.progress,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      progress: json['progress'],
    );
  }
}

// Profile Model
class Profile {
  final int id;
  final int userId;
  final String birthDate;
  final String language;
  final String country;
  final String sex;
  final String profilePhotoUrl;
  final int age;

  Profile({
    required this.id,
    required this.userId,
    required this.birthDate,
    required this.language,
    required this.country,
    required this.sex,
    required this.profilePhotoUrl,
    required this.age,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      userId: json['user_id'],
      birthDate: json['birth_date'],
      language: json['language'],
      country: json['country'],
      sex: json['sex'],
      profilePhotoUrl: json['profile_photo_url'],
      age: json['age'],
    );
  }
}

// Attendance Model
class Attendance {
  final int id;
  final String date;
  final int hasAttended;
  final int userId;

  Attendance({
    required this.id,
    required this.date,
    required this.hasAttended,
    required this.userId,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      date: json['date'],
      hasAttended: json['has_attended'],
      userId: json['user_id'],
    );
  }
}

// Student Model
class Studentt {
  final int id;
  final String name;
  final String email;
  final Profile profile;
  final List<Course> courses;
  final List<Attendance> attendances;

  Studentt({
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
    required this.courses,
    required this.attendances,
  });

  factory Studentt.fromJson(Map<String, dynamic> json) {
    return Studentt(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profile: Profile.fromJson(json['profile']),
      courses: (json['courses'] as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList(),
      attendances: (json['attendances'] as List)
          .map((attendanceJson) => Attendance.fromJson(attendanceJson))
          .toList(),
    );
  }
}


