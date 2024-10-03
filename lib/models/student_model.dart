// student_model.dart

class Profile {
  final int id;
  final String birthDate;
  final int userId;
  final String profilePhotoUrl;

  Profile({
    required this.id,
    required this.birthDate,
    required this.userId,
    required this.profilePhotoUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? 0,
      birthDate: json['birth_date'] ?? '',
      userId: json['user_id'] ?? 0,
      profilePhotoUrl: json['profile_photo_url'] ?? '',
    );
  }
}

class Student {
  final int id;
  final String name;
  final String email;
  final Profile profile;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Name',
      email: json['email'] ?? '',
      profile: Profile.fromJson(json['profile'] ?? {}),
    );
  }
}
