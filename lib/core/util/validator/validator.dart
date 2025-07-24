import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class Validator {
  static String? emptyValidator({value, message}) {
    List<String> errors = [];

    if (value.toString().trim().isEmpty) {
      errors.add(message);
    }

    return errors.isNotEmpty ? errors.join(",") : null;
  }

  static String dateToClock(String dateString) {
    DateFormat dateFormat = DateFormat("HH:mm:ss");
    DateTime dateTime = dateFormat.parse(dateString);

    return DateFormat('kk.mm').format(dateTime);
  }

  static String? nameValidator(value) {
    return value.toString().length <= 3 ? 'Nama tidak valid' : null;
  }

  static String? dateValidator(value) {
    return value.toString().length <= 3 ? 'Tanggal tidak valid' : null;
  }

  static Map<String, dynamic>? decodeJwtClaims(String jwtToken) {
    try {
      List<String> parts = jwtToken.split('.');

      if (parts.length != 3) {
        // Invalid JWT format
        return null;
      }

      String payload = utf8.decode(base64Url.decode(parts[1]));
      Map<String, dynamic> decodedClaims = json.decode(payload);

      return decodedClaims;
    } catch (e) {
      // Handle decoding errors
      return null;
    }
  }

  static String? emailValidator(value) {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    return !emailValid ? 'Email tidak valid' : null;
  }

  static String? passwordValidator(value) {
    return value.toString().length < 1
        ? 'Kata sandi tidak boleh kurang dari 1 karakter'
        : null;
  }

  static String? confirmPasswordValidator(String value, String olpw) {
    if (value == "") {
      return "confirm password kosong";
    } else if (value != olpw) {
      return "confirm password Tidak sama";
    } else {
      return null;
    }
  }

  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static Future<bool> isTokenStillValid(String token) async {
    final response = await http.get(
        Uri.parse(
            "https://urchin-app-hlgon.ondigitalocean.app/api/secured/ping"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        });

    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
