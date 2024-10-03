class ClassRoom {
  final int id;
  final String name;
  final int centerId;
  final int status;
  final String createdAt;
  final String updatedAt;
  final List<Student> students;

  ClassRoom({
    required this.id,
    required this.name,
    required this.centerId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.students,
  });

  factory ClassRoom.fromJson(Map<String, dynamic> json) {
    return ClassRoom(
      id: json['id'],
      name: json['name'],
      centerId: json['center_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      students: (json['students'] as List)
          .map((studentJson) => Student.fromJson(studentJson))
          .toList(),
    );
  }
}

class Student {
  final int id;
  final String name;
  final Profile profile;

  Student({
    required this.id,
    required this.name,
    required this.profile,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      profile: Profile.fromJson(json['profile']),
    );
  }
}

class Profile {
  final int id;
  final String birthDate;
  final String profilePhotoUrl;

  Profile({
    required this.id,
    required this.birthDate,
    required this.profilePhotoUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      birthDate: json['birth_date'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }
}



