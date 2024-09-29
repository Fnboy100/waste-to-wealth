import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:main/config/storeage/api_key_type.dart';


class SecureStorageService {
  static const FlutterSecureStorage
      _storage =
      FlutterSecureStorage();

  static Future<void> storeApiKey(ApiKeyType keyType, String value) async {
  await _storage.write(
    key: getApiKeyString(keyType),
    value: value,
  );
}


 static Future<String?> retrieveApiKey(ApiKeyType keyType) async {
  return await _storage.read(key: getApiKeyString(keyType));
}

  Future<void>
      deleteApiKey() async {
    await _storage.delete(key: 'api_wastemanagement_key');
  }
}
