import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/recipe_detail.dart';
import '../data_sources/remote/recipe_detail_remote_data_sources.dart';

abstract class RecipeDetailRepository {
  Future<Either<Failure, RecipeDetail>> getRecipeDetail(String recipeId);
  Future<Either<Failure, bool>> updateIngredientStatus(String recipeId, String ingredientName, bool isChecked);
}

class RecipeDetailRepositoryImpl implements RecipeDetailRepository {
  const RecipeDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final RecipeDetailRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, RecipeDetail>> getRecipeDetail(String recipeId) async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        print("🌐 Internet available, trying Recipe Detail API...");
        final model = await remoteDataSource.getRecipeDetail(recipeId, token);

        print("✅ Recipe Detail API success, saving to cache");
        await box.write("cached_recipe_detail_$recipeId", recipeDetailToJson(model));

        return Right(model);
      } on ServerException catch (e) {
        print("❌ Recipe Detail server error: $e, trying cache...");
        return _getCachedRecipeDetailData(recipeId, "ServerException");
      } on TimeOutException catch (e) {
        print("⏰ Recipe Detail timeout error: $e, trying cache...");
        return _getCachedRecipeDetailData(recipeId, "TimeOutException");
      } catch (e) {
        print("💥 Recipe Detail unknown error: $e, trying cache...");
        return _getCachedRecipeDetailData(recipeId, "UnknownException");
      }
    } else {
      print("📵 No internet for Recipe Detail, trying cache...");
      return _getCachedRecipeDetailData(recipeId, "NetworkFailure");
    }
  }

  Future<Either<Failure, RecipeDetail>> _getCachedRecipeDetailData(String recipeId, String errorType) async {
    try {
      final box = GetStorage();
      final cachedData = await box.read("cached_recipe_detail_$recipeId");

      if (cachedData != null) {
        print("✅ Recipe Detail cache found, returning cached data");
        final cachedRecipeDetail = recipeDetailFromJson(cachedData);
        return Right(cachedRecipeDetail);
      } else {
        print("❌ No recipe detail cache available");

        switch (errorType) {
          case "NetworkFailure":
            return Left(NetworkFailure());
          case "TimeOutException":
            return Left(TimeOutFailure());
          case "ServerException":
            return Left(ServerFailure());
          default:
            return Left(ServerFailure());
        }
      }
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateIngredientStatus(String recipeId, String ingredientName, bool isChecked) async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        print("🌐 Internet available, trying Update Recipe API...");

        // Get current recipe state to send full ingredients list
        final cachedData = await box.read("cached_recipe_detail_$recipeId");
        if (cachedData == null) {
          print("❌ No cached recipe data found for update");
          return Left(CacheFailure());
        }

        final cachedRecipeDetail = recipeDetailFromJson(cachedData);

        // Update the specific ingredient in the list
        final updatedIngredients = cachedRecipeDetail.data.ingredients.map((ingredient) {
          if (ingredient.name == ingredientName) {
            return DetailIngredient(
              id: ingredient.id,
              name: ingredient.name,
              isCheck: isChecked,
            );
          }
          return ingredient;
        }).toList();

        // Send full ingredients list to API
        final success = await remoteDataSource.updateRecipeIngredients(recipeId, updatedIngredients, token);

        if (success) {
          print("✅ Update Recipe success");

          // Update cache with new ingredient states
          final updatedRecipeDetail = RecipeDetail(
            status: cachedRecipeDetail.status,
            data: RecipeDetailData(
              id: cachedRecipeDetail.data.id,
              title: cachedRecipeDetail.data.title,
              description: cachedRecipeDetail.data.description,
              difficulty: cachedRecipeDetail.data.difficulty,
              culturalHeritage: cachedRecipeDetail.data.culturalHeritage,
              location: cachedRecipeDetail.data.location,
              cookTime: cachedRecipeDetail.data.cookTime,
              servingsPortion: cachedRecipeDetail.data.servingsPortion,
              ingredients: updatedIngredients,
              instructions: cachedRecipeDetail.data.instructions,
            ),
          );

          await box.write("cached_recipe_detail_$recipeId", recipeDetailToJson(updatedRecipeDetail));
          print("✅ Updated recipe cache");

          return Right(true);
        } else {
          print("❌ Update Recipe failed from server");
          return Left(ServerFailure());
        }
      } on ServerException catch (e) {
        print("❌ Update Recipe server error: $e");
        return Left(ServerFailure());
      } on TimeOutException catch (e) {
        print("⏰ Update Recipe timeout error: $e");
        return Left(TimeOutFailure());
      } catch (e) {
        print("💥 Update Recipe unknown error: $e");
        return Left(ServerFailure());
      }
    } else {
      print("📵 No internet for Update Recipe");
      return Left(NetworkFailure());
    }
  }
}