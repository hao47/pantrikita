import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pantrikita/core/error/exceptions.dart';
import 'package:pantrikita/core/error/failures.dart';
import 'package:pantrikita/core/util/local/local_storage.dart';
import 'package:pantrikita/core/util/network/network_info.dart';
import 'package:pantrikita/feature/pantry/data/data_sources/remote/pantry_remote_data_sources.dart';
import 'package:pantrikita/feature/pantry/data/domain/entities/pantry.dart';


abstract class PantryRepository {
  Future<Either<Failure, Pantry>> getPantry({
    required String category,
    required String status,
    required String filter,
    required String search
  });
}

class PantryRepositoryImpl implements PantryRepository {
  const PantryRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final PantryRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Pantry>> getPantry({
    required String category,
    required String status,
    required String filter,
    required String search
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        print("🌐 Internet available, trying Pantry API...");
        final model = await remoteDataSource.getPantry(token, category, status, filter, search);

        print("✅ Pantry API success, saving to cache");
        await box.write("cached_pantry", pantryToJson(model));

        return Right(model);
      } on ServerException catch (e) {
        print("❌ Pantry server error: $e, trying cache...");
        return _getCachedPantryData("ServerException");
      } on TimeOutException catch (e) {
        print("⏰ Pantry timeout error: $e, trying cache...");
        return _getCachedPantryData("TimeOutException");
      } catch (e) {
        print("💥 Pantry unknown error: $e, trying cache...");
        return _getCachedPantryData("UnknownException");
      }
    } else {
      print("📵 No internet for Pantry, trying cache...");
      return _getCachedPantryData("NetworkFailure");
    }
  }

  Future<Either<Failure, Pantry>> _getCachedPantryData(String errorType) async {
    try {
      final box = GetStorage();
      final cachedData = await box.read("cached_pantry");

      if (cachedData != null) {
        print("✅ Pantry cache found, returning cached data");
        final cachedPantry = pantryFromJson(cachedData);
        return Right(cachedPantry);
      } else {
        print("❌ No pantry cache available");

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