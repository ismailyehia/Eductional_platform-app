
class User {
  final int userid;
  final String name;
  final String email;
  final Profile profile;

  User(
      {required this.userid,
      required this.name,
      required this.email,
      required this.profile});

      factory User.fromJson(Map<String, dynamic> json) {
  return User(
    userid: json['id'] ?? 0,
    name: json['name'] ?? "no Name",
    email: json['email'] ?? "no email",
    profile: json['profile'] != null 
      ? Profile.fromJson(json['profile']) 
      : Profile( // Fallback default profile
          id: 0, 
          birth_date: "", 
          country: "", 
          phone: "", 
          sex: "", 
          profile_photo_url: "https://quran.smartwork.com.tr/img/default_profile_female_adult.jpg", 
          age: 0
        ),
  );
}


  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     userid: json['id'] ?? 0,
  //     name: json['name'] ??"no Name",
  //     email: json['email'] ?? "no email",
  //     profile:  Profile.fromJson(json['profile'] ?? {}),
      
  //   );
  // }
}

class Profile {
  final int id;
  final String birth_date;
  final String country;
  final String phone;
  final String sex;
  final String profile_photo_url;
  final int age;

  Profile({
    required this.age,
    required this.id,
    required this.birth_date,
    required this.country,
    required this.phone,
    required this.sex,
    required this.profile_photo_url,
  });
    

    

   factory Profile.fromJson(Map<String, dynamic> json) {

    int ageValue;
    try {
      ageValue = int.parse(json['age'].toString());
    } catch (e) {
      ageValue = 0; // Default age value if parsing fails
    }
    return Profile(
      id: json['id']?? 0,
      birth_date: json['birth_date']??"",
      country: json['country']??"",
      phone: json['phone']??"",
      sex: json['sex']??"",
      profile_photo_url: json['profile_photo_url'] ?? "https://quran.smartwork.com.tr/img/default_profile_female_adult.jpg",
      age: ageValue,
    );
  }
}


