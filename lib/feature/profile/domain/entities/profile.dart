import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  String message;
  Data data;

  Profile({
    required this.message,
    required this.data,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Bio bio;
  Impact impact;

  Data({
    required this.bio,
    required this.impact,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bio: Bio.fromJson(json["bio"]),
    impact: Impact.fromJson(json["impact"]),
  );

  Map<String, dynamic> toJson() => {
    "bio": bio.toJson(),
    "impact": impact.toJson(),
  };
}

class Bio {
  String id;
  String username;
  String email;

  Bio({
    required this.id,
    required this.username,
    required this.email,
  });

  factory Bio.fromJson(Map<String, dynamic> json) => Bio(
    id: json["id"],
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
  };
}

class Impact {
  int foodSave;
  String wasteReduced;
  int itemScanned;
  int expiringSoon;

  Impact({
    required this.foodSave,
    required this.wasteReduced,
    required this.itemScanned,
    required this.expiringSoon,
  });

  factory Impact.fromJson(Map<String, dynamic> json) => Impact(
    foodSave: json["food_save"],
    wasteReduced: json["waste_reduce"],
    itemScanned: json["item_scanned"],
    expiringSoon: json["expiring_soon"],
  );

  Map<String, dynamic> toJson() => {
    "food_save": foodSave,
    "waste_reduce": wasteReduced,
    "item_scanned": itemScanned,
    "expiring_soon": expiringSoon,
  };
}
