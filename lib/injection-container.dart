import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/util/local/local_storage.dart';
import 'core/util/network/network_info.dart';
import 'feature/profile/data/data_sources/remote/profile_remote_data_sources.dart';
import 'feature/profile/data/repositories/profile_repository.dart';
import 'feature/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.I;

Future<void> initializeServiceLocator() async {
  /// Feature Page
  _initializeProfileFeature();

  /// Core
  ///
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<LocalStorage>(
        () => LocalStorageImpl(
      getStorage: sl(),
    ),
  );

  /// External
  final box = GetStorage();
  sl.registerLazySingleton(() => box);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}

void _initializeProfileFeature() {
  // bloc
  sl.registerFactory(
        () => ProfileBloc(
      repository: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localStorage: sl(),
    ),
  );


}