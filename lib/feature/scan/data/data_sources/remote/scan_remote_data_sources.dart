import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pantrikita/feature/scan/domain/entities/identify.dart';
import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/scan.dart';

abstract class ScanRemoteDataSource {
  Future<Scan> postScan(
    String name,
    String category,
    String expiring_date,
    String location,
    String token,
  );

  Future<Identify> postIdentify(XFile imageFile, String token);
}

class ScanRemoteDataSourceImpl implements ScanRemoteDataSource {
  const ScanRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Scan> postScan(
    String name,
    String category,
    String expiring_date,
    String location,
    String token,
  ) async {
    final url = Uri.parse('${Api.url}/scan');

    final body = {
      "name": name,
      "category": category,
      "expiring_date": expiring_date,
      "location": location,
    };

    final response = await client
        .post(url, headers: Api.headersToken(token), body: jsonEncode(body))
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw const TimeOutException(),
        );

    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return scanFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
  Future<Identify> postIdentify(XFile imageFile, String token) async {
    final url = Uri.parse('${Api.url}/scan/identify');

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(Api.headersToken(token))
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path)); // ganti 'image' ke 'file'

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('RESPONSE BODY: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return identifyFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }

}
