import 'package:http/http.dart' as http;
import 'package:pantrikita/core/api/api.dart';
import 'package:pantrikita/core/error/exceptions.dart';
import 'package:pantrikita/feature/recipe/domain/entities/recipe.dart';

abstract class RecipeRemoteDataSource {
  Future<Recipe> getRecipes(String token);
  Future<Recipe> regenerateRecipes(String token);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  const RecipeRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Recipe> getRecipes(String token) async {
    final url = Uri.parse('${Api.url}/recipe');

    final response = await client
        .get(
      url,
      headers: Api.headersToken(token),
    )
        .timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw const TimeOutException(),
    );

    if (response.statusCode == 200) {
      return recipeFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<Recipe> regenerateRecipes(String token) async {
    final url = Uri.parse('${Api.url}/recipe/regenerate');

    final response = await client
        .get(
      url,
      headers: Api.headersToken(token),
    )
        .timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw const TimeOutException(),
    );

    if (response.statusCode == 200) {
      return recipeFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}