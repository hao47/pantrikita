import 'package:http/http.dart' as http;
import 'package:pantrikita/feature/pantry/data/domain/entities/pantry.dart';
import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';

abstract class PantryRemoteDataSource {
  Future<Pantry> getPantry(String token, String category, String status, String filter, String search);
}

class PantryRemoteDataSourceImpl implements PantryRemoteDataSource {
  const PantryRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Pantry> getPantry(String token, String category, String status, String filter, String search) async {
    final url = Uri.parse('${Api.url}/pantry?categories=$category&status=$status&filter=$filter&search=$search');

    final response = await client.get(
      url,
      headers: Api.headersToken(token),
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw const TimeOutException(),
    );

    if (response.statusCode == 200) {
      return pantryFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
