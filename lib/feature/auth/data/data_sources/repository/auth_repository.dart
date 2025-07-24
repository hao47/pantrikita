import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/util/local/local_storage.dart';
import '../../../../../core/util/network/network_info.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/entities/register.dart';
import '../remote/auth_remote_data_sources.dart';


abstract class AuthRepository {
  Future<Either<Failure, Login>> getLogin(String email,String password);
  Future<Either<Failure, Register>> getRegister(String email, String password, String username);
}

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final AuthRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Login>> getLogin(String email,String password) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getLogin(email,password);

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
  Future<Either<Failure, Register>> getRegister(
      String email,
      String password,
      String username,

      ) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getRegister(email, password, username);
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
