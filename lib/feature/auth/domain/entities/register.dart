import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  String message;

  Register({
    required this.message,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
