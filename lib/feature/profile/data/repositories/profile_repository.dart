import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/profile.dart';
import '../data_sources/remote/profile_remote_data_sources.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, bool>> logout();
}

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final ProfileRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        final model = await remoteDataSource.getProfile(token);

        print("✅ Profile API success, saving to cache");
        await box.write("cached_profile", profileToJson(model));

        return Right(model);
      } on ServerException {
        return _getCachedProfileData("ServerException");
      } on TimeOutException {
        return _getCachedProfileData("TimeOutException");
      } catch (e) {
        return _getCachedProfileData("UnknownException");
      }
    } else {
      return _getCachedProfileData("NetworkFailure");
    }
  }

  Future<Either<Failure, Profile>> _getCachedProfileData(String errorType) async {
    try {
      final box = GetStorage();
      final cachedData = await box.read("cached_profile");

      if (cachedData != null) {

        print("✅ Profile cache found, returning cached data");
        final cachedProfile = profileFromJson(cachedData);
        return Right(cachedProfile);
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
  Future<Either<Failure, bool>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        final success = await remoteDataSource.logout(token);

        if (success) {
          await box.remove("user_token");
          await box.remove("cached_profile");
          await box.remove("user_data");
          await box.remove("login_data");

          return Right(true);
        } else {
          return Left(ServerFailure());
        }
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