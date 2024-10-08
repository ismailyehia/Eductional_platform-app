class Progressget {
  final int id;
  final int courseId;
  final String date;
  final String note;
  final int score;
  final Lesson? lesson;
  final Surah? surah;
  final int? from;
  final int? to;
  Progressget({
    required this.score,
    required this.courseId,
    required this.id,
    required this.date,
    required this.note,
    this.lesson,
    this.surah,
    this.from,
    this.to,
  });

  factory Progressget.fromJson(Map<String, dynamic> json) {
    return Progressget(
      id: json['id'] as int,
      courseId: json['course_id'] as int,
      date: json['date'] as String,
      note: json['note'] as String,
      score: json['score'] as int,
      lesson: json['lesson'] != null
          ? Lesson.fromJson(json['lesson'])
          : null, // Handle nullable lesson
      surah: json['surah'] != null
          ? Surah.fromJson(json['surah'])
          : null, // Handle nullable surah
      from: json['from'] != null ? json['from'] as int : null, // Nullable from
      to: json['to'] != null ? json['to'] as int : null, // Nullable to
    );
  }
}

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

class Surah {
  final int id;
  final String nameAr;

  Surah({
    required this.id,
    required this.nameAr,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['id'] as int,
      nameAr: json['name_ar'] as String,
    );
  }
}


