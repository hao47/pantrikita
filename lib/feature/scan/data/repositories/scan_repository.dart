import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pantrikita/feature/scan/domain/entities/identify.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/scan.dart';
import '../data_sources/remote/scan_remote_data_sources.dart';

abstract class ScanRepository {
  Future<Either<Failure, Scan>> postScan(String name, String category,String expiring_date, String location);
  Future<Either<Failure, Identify>> postIdentify(XFile imageFile);

}

class ScanRepositoryImpl implements ScanRepository {
  const ScanRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final ScanRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Scan>> postScan(String name, String category,String expiring_date, String location) async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");
        final model = await remoteDataSource.postScan(name,category,expiring_date,location,token);
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

  @override
  Future<Either<Failure, Identify>> postIdentify(XFile imageFile) async {
    if (await networkInfo.isConnected) {
      try {
        final box = GetStorage();
        final token = await box.read("user_token");
        final model = await remoteDataSource.postIdentify(imageFile,token);
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