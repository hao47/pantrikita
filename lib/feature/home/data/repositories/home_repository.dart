import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/home.dart';
import '../data_sources/remote/home_remote_data_sources.dart';

abstract class HomeRepository {
  Future<Either<Failure, Home>> getHome();

}

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final HomeRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Home>> getHome() async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");

        print("✅ Home Detail API success");
        final model = await remoteDataSource.getHome(token);
        return Right(model);
      } on ServerException {
        return Left(ServerFailure());
      } on TimeOutException {
        return Left(TimeOutFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }


}