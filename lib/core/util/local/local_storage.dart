import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../error/exceptions.dart';


abstract class LocalStorage {
  Future<String> getTokenString(String key);

  Future<void> setTokenString(String key, String token);

  Future<void> removeToken(String key);
}

class LocalStorageImpl implements LocalStorage {
  const LocalStorageImpl({required this.getStorage});

  final GetStorage getStorage;

  @override
  Future<String> getTokenString(String key) {
    final token = getStorage.read(key);
    if (token != null) {
      return Future.value(token);
    } else {
      throw const CacheException();
    }
  }

  @override
  Future<void> setTokenString(String key, String value) {
    return getStorage.write(key, value);
  }

  @override
  Future<void> removeToken(String key) async {
    final con = await getStorage.remove(key);

  }
}
