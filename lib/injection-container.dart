import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pantrikita/feature/pantry/presentation/bloc/pantry_bloc.dart';

import 'core/util/local/local_storage.dart';
import 'core/util/network/network_info.dart';

final sl = GetIt.I;

Future<void> initializeServiceLocator() async {
  /// Feature Page
  _initializePantryFeature();

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
  sl.registerLazySingleton(() => InternetConnectionChecker);
}

void _initializePantryFeature() {
  // bloc
  sl.registerFactory(
        () => PantryBloc(),
  );
}