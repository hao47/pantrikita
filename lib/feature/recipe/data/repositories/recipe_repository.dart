import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pantrikita/core/error/exceptions.dart';
import 'package:pantrikita/core/error/failures.dart';
import 'package:pantrikita/core/util/local/local_storage.dart';
import 'package:pantrikita/core/util/network/network_info.dart';
import 'package:pantrikita/feature/recipe/domain/entities/recipe.dart';
import '../data_sources/remote/recipe_remote_data_sources.dart';

abstract class RecipeRepository {
  Future<Either<Failure, Recipe>> getRecipes();
  Future<Either<Failure, Recipe>> regenerateRecipes();
}

class RecipeRepositoryImpl implements RecipeRepository {
  const RecipeRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final RecipeRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Recipe>> getRecipes() async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        final model = await remoteDataSource.getRecipes(token);

        print("✅ Recipe API success, saving to cache");
        await box.write("cached_recipes", recipeToJson(model));

        return Right(model);
      } on ServerException {
        return _getCachedData("ServerException");
      } on TimeOutException {
        return _getCachedData("TimeOutException");
      } catch (e) {
        return _getCachedData("UnknownException");
      }
    } else {
      return _getCachedData("NetworkFailure");
    }
  }

  @override
  Future<Either<Failure, Recipe>> regenerateRecipes() async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        final model = await remoteDataSource.regenerateRecipes(token);

        print("✅ Recipe Regenerate API success, saving to cache");
        await box.write("cached_recipes", recipeToJson(model));

        return Right(model);
      } on ServerException {
        return _getCachedData("ServerException");
      } on TimeOutException {
        return _getCachedData("TimeOutException");
      } catch (e) {
        return _getCachedData("UnknownException");
      }
    } else {
      return _getCachedData("NetworkFailure");
    }
  }

  Future<Either<Failure, Recipe>> _getCachedData(String errorType) async {
    try {
      final box = GetStorage();
      final cachedData = await box.read("cached_recipes");

      if (cachedData != null) {
        print("✅ Cache found, returning cached data");

        final cachedRecipes = recipeFromJson(cachedData);
        return Right(cachedRecipes);
      } else {

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
}