import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pantrikita/core/error/exceptions.dart';
import 'package:pantrikita/core/error/failures.dart';
import 'package:pantrikita/core/util/local/local_storage.dart';
import 'package:pantrikita/core/util/network/network_info.dart';
import 'package:pantrikita/feature/pantry_detail/data/data_sources/remote/pantry_remote_data_sources.dart';
import 'package:pantrikita/feature/pantry_detail/data/domain/entities/pantry_detail.dart';

abstract class PantryDetailRepository {
  Future<Either<Failure, PantryDetail>> getPantryDetail({
    required String id,
  });
}

class PantryDetailRepositoryImpl implements PantryDetailRepository {
  const PantryDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final PantryDetailRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, PantryDetail>> getPantryDetail({
    required String id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        print("🌐 Internet available, trying Pantry Detail API...");
        final model = await remoteDataSource.getPantryDetail(token, id);

        print("✅ Pantry Detail API success, saving to cache");
        await box.write("cached_pantry_detail", pantryDetailToJson(model));

        return Right(model);
      } on ServerException catch (e) {
        print("❌ Pantry Detail server error: $e, trying cache...");
        return _getCachedPantryDetailData("ServerException");
      } on TimeOutException catch (e) {
        print("⏰ Pantry Detail timeout error: $e, trying cache...");
        return _getCachedPantryDetailData("TimeOutException");
      } catch (e) {
        print("💥 Pantry Detail unknown error: $e, trying cache...");
        return _getCachedPantryDetailData("UnknownException");
      }
    } else {
      print("📵 No internet for Pantry Detail, trying cache...");
      return _getCachedPantryDetailData("NetworkFailure");
    }
  }

  Future<Either<Failure, PantryDetail>> _getCachedPantryDetailData(String errorType) async {
    try {
      final box = GetStorage();
      final cachedData = await box.read("cached_pantry");

      if (cachedData != null) {
        print("✅ Pantry Detail cache found, returning cached data");
        final cachedPantryDetail = pantryDetailFromJson(cachedData);
        return Right(cachedPantryDetail);
      } else {
        print("❌ No pantry detail cache available");

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