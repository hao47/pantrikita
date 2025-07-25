import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';

abstract class FCMService {
  Future<String?> generateToken();
  Future<String?> getCurrentToken();
  String? getCachedToken();
  void clearToken();
}

class FCMServiceImpl implements FCMService {
  final FirebaseMessaging _messaging;
  final GetStorage _storage;

  FCMServiceImpl({
    required FirebaseMessaging messaging,
    required GetStorage storage,
  }) : _messaging = messaging, _storage = storage;

  @override
  Future<String?> generateToken() async {
    try {

      String? token = await _messaging.getToken();

      if (token != null) {

        _storage.write('fcm_token', token);

        _messaging.onTokenRefresh.listen((newToken) {
          _storage.write('fcm_token', newToken);
        });

        return token;
      } else {
      }
    } catch (e) {
    }

    return null;
  }

  @override
  Future<String?> getCurrentToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      return null;
    }
  }

  @override
  String? getCachedToken() {
    return _storage.read('fcm_token');
  }

  @override
  void clearToken() {
    _storage.remove('fcm_token');
  }
}