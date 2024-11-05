class Progressget {
  final int id; 
  final int? courseId; // Nullable int
  final String date; // Nullable string
  final String? note; // Nullable string
  final int? score; // Nullable int
  final Lesson? lesson; // Nullable lesson
  final Surah? surah; // Nullable surah
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
      id: json['id'] as int ,
      courseId: json['course_id'] != null ? json['course_id'] as int : null,
      date: json['date'] as String, 
      note: json['note'] as String?, 
      score: json['score'] != null ? json['score'] as int : null, 
      lesson: json['lesson'] != null ? Lesson.fromJson(json['lesson']) : null, 
      surah: json['surah'] != null ? Surah.fromJson(json['surah']) : null,
      from: json['from'] != null ? json['from'] as int : null,
      to: json['to'] != null ? json['to'] as int : null,
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


