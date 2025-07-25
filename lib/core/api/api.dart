import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static String get url => 'https://dfc4c703a89b.ngrok-free.app' ?? 'default_value';
  static String get baseUrlImage => dotenv.env['BASE_URL_IMAGE'] ?? 'default_value';
  static Map<String, String> headers() {
    return {
      'Accept': 'application/json',
      'Content-type': 'application/json',
    };
  }

  static Map<String, String> headersToken(String token) {
    return {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}