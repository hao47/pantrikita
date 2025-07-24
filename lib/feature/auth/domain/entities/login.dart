// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String message;
  Data data;

  Login({
    required this.message,
    required this.data,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String accessToken;
  String nama;

  Data({
    required this.accessToken,
    required this.nama,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    nama: json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "nama": nama,
  };
}
