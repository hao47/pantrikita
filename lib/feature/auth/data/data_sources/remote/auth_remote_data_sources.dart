import 'package:http/http.dart' as http;
import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import 'dart:convert';

import '../../../domain/entities/login.dart';
import '../../../domain/entities/register.dart';

abstract class AuthRemoteDataSource {
  Future<Login> getLogin(String email, String password);
  Future<Register> getRegister(String email, String password, String username);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Login> getLogin(String email, String password) async {
    final url = Uri.parse('${Api.url}/auth/login');

    final body = {"email": email, "password": password};

    final response = await client
        .post(url, headers: Api.headers(), body: jsonEncode(body))
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw const TimeOutException(),
        );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      return loginFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<Register> getRegister(
    String email,
    String password,
    String username,
    //
  ) async {
    final url = Uri.parse('${Api.url}/auth/register');

    final body = jsonEncode({
      "email": email,
      "password": password,
      "username": username,
    });

    final response = await client
        .post(url, headers: Api.headers(), body: body)
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw const TimeOutException(),
        );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      return registerFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
