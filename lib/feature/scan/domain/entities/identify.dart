// To parse this JSON data, do
//
//     final identify = identifyFromJson(jsonString);

import 'dart:convert';

Identify identifyFromJson(String str) => Identify.fromJson(json.decode(str));

String identifyToJson(Identify data) => json.encode(data.toJson());

class Identify {
  String message;
  Data data;

  Identify({
    required this.message,
    required this.data,
  });

  factory Identify.fromJson(Map<String, dynamic> json) => Identify(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String name;
  String category;
  String expiringDate;
  String location;

  Data({
    required this.name,
    required this.category,
    required this.expiringDate,
    required this.location,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    category: json["category"],
    expiringDate: json["expiring_date"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "category": category,
    "expiring_date": expiringDate,
    "location": location,
  };
}
