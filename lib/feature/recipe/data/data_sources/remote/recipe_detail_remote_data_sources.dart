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

    print("🌐 Making Recipe Detail API call to: $url");

    try {
      final response = await client
          .get(
        url,
        headers: Api.headersToken(token),
      )
          .timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print("⏰ Recipe Detail API call timeout after 15 seconds");
          throw const TimeOutException();
        },
      );

      print("📡 Recipe Detail API Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        print(response.body);
        final recipeDetail = recipeDetailFromJson(response.body);
        print("✅ Successfully parsed recipe detail: ${recipeDetail.data.title}");
        return recipeDetail;
      } else {
        print("❌ Server returned error: ${response.statusCode}");
        throw const ServerException();
      }
    } catch (e) {
      print("💥 Recipe Detail DataSource error: $e");
      if (e is TimeOutException) {
        rethrow;
      } else {
        throw const ServerException();
      }
    }
  }

  Future<bool> updateIngredientStatus(String recipeId, String ingredientName, bool isChecked, String token) async {
    final url = Uri.parse('${Api.url}/recipe/$recipeId');

    print("🌐 Making Update Recipe API call to: $url");
    print("📝 Updating ingredient: $ingredientName to isChecked: $isChecked");

    try {
      // Note: This method needs the full ingredients list to make the API call
      // The actual update logic should be handled in the repository layer
      // where we have access to the current recipe state
      throw UnimplementedError("Use updateRecipeIngredients method instead");
    } catch (e) {
      print("💥 Update Ingredient DataSource error: $e");
      rethrow;
    }
  }

  @override
  Future<bool> updateRecipeIngredients(String recipeId, List<DetailIngredient> ingredients, String token) async {
    final url = Uri.parse('${Api.url}/recipe/$recipeId');

    print("🌐 Making Update Recipe API call to: $url");
    print("📝 Updating recipe with ${ingredients.length} ingredients");

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
          print("⏰ Update Recipe API call timeout after 15 seconds");
          throw const TimeOutException();
        },
      );

      print("📡 Update Recipe API Response: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Successfully updated recipe ingredients");
        return true;
      } else {
        print("❌ Server returned error: ${response.statusCode}");
        throw const ServerException();
      }
    } catch (e) {
      print("💥 Update Recipe DataSource error: $e");
      if (e is TimeOutException) {
        rethrow;
      } else {
        throw const ServerException();
      }
    }
  }
}