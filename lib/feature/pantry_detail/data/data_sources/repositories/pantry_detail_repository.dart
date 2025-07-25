import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pantrikita/core/error/exceptions.dart';
import 'package:pantrikita/core/error/failures.dart';
import 'package:pantrikita/core/util/local/local_storage.dart';
import 'package:pantrikita/core/util/network/network_info.dart';
import 'package:pantrikita/feature/pantry_detail/data/data_sources/remote/pantry_detail_remote_data_sources.dart';
import 'package:pantrikita/feature/pantry_detail/data/domain/entities/pantry_detail.dart';

abstract class PantryDetailRepository {
  Future<Either<Failure, PantryDetail>> getPantryDetail({
    required String id,
  });
  Future<Either<Failure, String>> putPantryDetail({
    required String id,
    required String status,
  });
  Future<Either<Failure, String>> deletePantryDetail({
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

        final model = await remoteDataSource.getPantryDetail(token, id);

        print("✅ Pantry Detail API success, saving to cache");
        await box.write("cached_pantry_detail", pantryDetailToJson(model));

        return Right(model);
      } on ServerException {
        return _getCachedPantryDetailData("ServerException");
      } on TimeOutException {
        return _getCachedPantryDetailData("TimeOutException");
      } catch (e) {
        return _getCachedPantryDetailData("UnknownException");
      }
    } else {
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
  Future<Either<Failure, String>> putPantryDetail({
    required String id,
    required String status,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        final response = await remoteDataSource.putPantryDetail(token, id, status);

        print("✅ PUT Pantry Detail API success");

        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on TimeOutException {
        return Left(TimeOutFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deletePantryDetail({
    required String id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        final response = await remoteDataSource.deletePantryDetail(token, id);

        print("✅ DELETE Pantry Detail API success");

        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on TimeOutException {
        return Left(TimeOutFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}