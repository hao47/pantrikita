// To parse this JSON data, do
//
//     final scan = scanFromJson(jsonString);

import 'dart:convert';

Scan scanFromJson(String str) => Scan.fromJson(json.decode(str));

String scanToJson(Scan data) => json.encode(data.toJson());

class Scan {
  String message;

  Scan({
    required this.message,
  });

  factory Scan.fromJson(Map<String, dynamic> json) => Scan(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
