
//class for pivot 
class Pivot {
  final int userId;
  final int classRoomId;

  Pivot({required this.userId, required this.classRoomId});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json['user_id'] ?? 0,
      classRoomId: json['class_room_id'] ?? 0,
    );
  }
}




//class for classes
class ClassStudents {
  final int id;
  final String name;
  final int centerId;
  final bool status;
   final Pivot pivot;

  ClassStudents({
    required this.id,
    required this.name,
    required this.centerId,
    required this.status,
    required this.pivot,
  });


  factory ClassStudents.fromJson(Map<String ,dynamic> json){

    return ClassStudents(
      id: json['id']?? 0,
      name: json['name']?? "no Name",
      centerId: json['center_id']?? 0,
      status: json['status']==1,
      pivot: Pivot.fromJson(json['pivot'] ?? {}),
      );

  }


}


