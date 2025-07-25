import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pantrikita/core/api/api.dart';
import 'package:pantrikita/core/error/exceptions.dart';
import 'package:pantrikita/feature/recipe/domain/entities/recipe_detail.dart';

abstract class RecipeDetailRemoteDataSource {
  Future<RecipeDetail> getRecipeDetail(String recipeId, String token);
  Future<bool> updateRecipeIngredients(String recipeId, List<DetailIngredient> ingredients, String token);
}

class RecipeDetailRemoteDataSourceImpl implements RecipeDetailRemoteDataSource {
  const RecipeDetailRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<RecipeDetail> getRecipeDetail(String recipeId, String token) async {
    final url = Uri.parse('${Api.url}/recipe/$recipeId');


    try {
      final response = await client
          .get(
        url,
        headers: Api.headersToken(token),
      )
          .timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw const TimeOutException();
        },
      );


      if (response.statusCode == 200) {
        final recipeDetail = recipeDetailFromJson(response.body);
        return recipeDetail;
      } else {
        throw const ServerException();
      }
    } catch (e) {
      if (e is TimeOutException) {
        rethrow;
      } else {
        throw const ServerException();
      }
    }
  }

  Future<bool> updateIngredientStatus(String recipeId, String ingredientName, bool isChecked, String token) async {
    final url = Uri.parse('${Api.url}/recipe/$recipeId');

    print("📝 Updating ingredient: $ingredientName to isChecked: $isChecked");

    try {
      // Note: This method needs the full ingredients list to make the API call
      // The actual update logic should be handled in the repository layer
      // where we have access to the current recipe state
      throw UnimplementedError("Use updateRecipeIngredients method instead");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateRecipeIngredients(String recipeId, List<DetailIngredient> ingredients, String token) async {
    final url = Uri.parse('${Api.url}/recipe/$recipeId');


    try {
      final requestBody = {
        'ingredients': ingredients.map((ingredient) => {
          'id': ingredient.id,
          'name': ingredient.name,
          'is_check': ingredient.isCheck,
        }).toList(),
      };

      final response = await client
          .put(
        url,
        headers: {
          ...Api.headersToken(token),
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      )
          .timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw const TimeOutException();
        },
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw const ServerException();
      }
    } catch (e) {
      if (e is TimeOutException) {
        rethrow;
      } else {
        throw const ServerException();
      }
    }
  }
}