import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pantrikita/feature/pantry_detail/data/domain/entities/pantry_detail.dart';
import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';

abstract class PantryDetailRemoteDataSource {
  Future<PantryDetail> getPantryDetail(String token, String id);
  Future<String> putPantryDetail(String token, String id, String status);
  Future<String> deletePantryDetail(String token, String id);
}

class PantryDetailRemoteDataSourceImpl implements PantryDetailRemoteDataSource {
  const PantryDetailRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<PantryDetail> getPantryDetail(String token, String id) async {
    final url = Uri.parse('${Api.url}/pantry/$id');

    final response = await client.get(
      url,
      headers: Api.headersToken(token),
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw const TimeOutException(),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return pantryDetailFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<String> putPantryDetail(String token, String id, String status) async {
    final url = Uri.parse('${Api.url}/pantry/$id');

    final body = {
      "status": status,
    };

    final response = await client.put(
      url,
      headers: {
        ...Api.headersToken(token),
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw const TimeOutException(),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<String> deletePantryDetail(String token, String id) async {
    final url = Uri.parse('${Api.url}/pantry/$id');

    final response = await client.delete(
      url,
      headers: Api.headersToken(token),
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw const TimeOutException(),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw const ServerException();
    }
  }
}
