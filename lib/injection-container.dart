import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pantrikita/feature/auth/data/data_sources/remote/auth_remote_data_sources.dart';
import 'package:pantrikita/feature/auth/data/data_sources/repository/auth_repository.dart';
import 'package:pantrikita/feature/pantry/data/data_sources/remote/pantry_remote_data_sources.dart';
import 'package:pantrikita/feature/pantry/data/data_sources/repositories/pantry_repository.dart';
import 'package:pantrikita/feature/pantry_detail/data/data_sources/remote/pantry_detail_remote_data_sources.dart';
import 'package:pantrikita/feature/pantry_detail/data/data_sources/repositories/pantry_detail_repository.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/bloc/pantry_detail_bloc.dart';

import 'core/util/local/local_storage.dart';
import 'core/util/network/network_info.dart';
import 'feature/auth/presentation/bloc/login_bloc.dart';
import 'feature/home/data/data_sources/remote/home_remote_data_sources.dart';
import 'feature/home/data/repositories/home_repository.dart';
import 'feature/home/presentation/bloc/home_bloc.dart';
import 'feature/pantry/presentation/bloc/pantry_bloc.dart';
import 'feature/profile/data/data_sources/remote/profile_remote_data_sources.dart';
import 'feature/profile/data/repositories/profile_repository.dart';
import 'feature/profile/presentation/bloc/profile_bloc.dart';
import 'feature/auth/presentation/bloc/register_bloc.dart';
import 'feature/scan/data/data_sources/remote/scan_remote_data_sources.dart';
import 'feature/scan/data/repositories/scan_repository.dart';
import 'feature/scan/presentation/bloc/scan_bloc.dart';
import 'feature/recipe/data/data_sources/remote/recipe_detail_remote_data_sources.dart';
import 'feature/recipe/data/data_sources/remote/recipe_remote_data_sources.dart';
import 'feature/recipe/data/repositories/recipe_detail_repository.dart';
import 'feature/recipe/data/repositories/recipe_repository.dart';
import 'feature/recipe/presentation/bloc/recipe_bloc.dart';
import 'feature/recipe/presentation/bloc/recipe_detail_bloc.dart';

final sl = GetIt.I;

Future<void> initializeServiceLocator() async {
  /// Feature Page

  _initializeAuthFeature();
  _initializeProfileFeature();
  _initializeRecipeFeature();
  _initializeRecipeDetailFeature();
  _initializePantryFeature();
  _initializeHomeFeature();
  _initializePantryDetailFeature();
  // _initializeHomeFeature();
  _initializeScanFeature();

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


void _initializeAuthFeature() {
  // bloc
  sl.registerFactory(
        () => LoginBloc(
      repository: sl(),
    ),
  );

  // bloc
  sl.registerFactory(
        () => RegisterBloc(
      repository: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localStorage: sl(),
    ),
  );
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

void _initializeRecipeFeature() {
  // bloc
  sl.registerFactory(
        () =>
        RecipeBloc(
          repository: sl(),
        ),
  );

  // data sources
  sl.registerLazySingleton<RecipeRemoteDataSource>(
        () =>
        RecipeRemoteDataSourceImpl(
          client: sl(),
        ),
  );

  // repository
  sl.registerLazySingleton<RecipeRepository>(
        () =>
        RecipeRepositoryImpl(
          remoteDataSource: sl(),
          networkInfo: sl(),
          localStorage: sl(),
        ),
  );
}

void _initializeRecipeDetailFeature() {
  // bloc
  sl.registerFactory(
        () =>
        RecipeDetailBloc(
          repository: sl(),
        ),
  );

  // data sources
  sl.registerLazySingleton<RecipeDetailRemoteDataSource>(
        () =>
        RecipeDetailRemoteDataSourceImpl(
          client: sl(),
        ),
  );

  // repository
  sl.registerLazySingleton<RecipeDetailRepository>(
        () =>
        RecipeDetailRepositoryImpl(
          remoteDataSource: sl(),
          networkInfo: sl(),
          localStorage: sl(),
        ),
  );
}


void _initializeHomeFeature() {
  // bloc
  sl.registerFactory(
        () => HomeBloc(
      repository: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localStorage: sl(),
    ),
  );


}


void _initializeScanFeature() {
  // bloc
  sl.registerFactory(
        () => ScanBloc(
      repository: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<ScanRemoteDataSource>(
        () => ScanRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<ScanRepository>(
        () => ScanRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localStorage: sl(),
    ),
  );


}

void _initializePantryFeature() {
  // bloc
  sl.registerFactory(
        () => PantryBloc(
      repository: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<PantryRemoteDataSource>(
        () => PantryRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<PantryRepository>(
        () => PantryRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localStorage: sl(),
    ),
  );
}

void _initializePantryDetailFeature() {
  // bloc
  sl.registerFactory(
        () => PantryDetailBloc(
      repository: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<PantryDetailRemoteDataSource>(
        () => PantryDetailRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<PantryDetailRepository>(
        () => PantryDetailRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localStorage: sl(),
    ),
  );
}
