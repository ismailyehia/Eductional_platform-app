class Course {
  final int id;
  final String name;
  final String type;
  final int progress;

  Course( {required this.id, required this.name, required this.progress , required this.type});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      progress: json['progress'],
    );
  }
}

class ClassModel {
  final int id;
  final String name;
  final List<Course> courses;

  ClassModel({required this.id, required this.name, required this.courses});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      name: json['name'],
      courses: (json['courses'] as List)
          .map((course) => Course.fromJson(course))
          .toList(),
    );
  }
}
