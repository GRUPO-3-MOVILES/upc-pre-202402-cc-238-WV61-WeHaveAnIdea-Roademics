import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as developer;

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyToken = 'jwt_token';

  static Future<void> saveToken(String token) async {
    final bearerToken = 'Bearer $token';
    await _storage.write(key: _keyToken, value: bearerToken);
    developer.log("TokenStorage: Token saved: $bearerToken");
  }

  static Future<String?> getToken() async {
    final token = await _storage.read(key: _keyToken);
    developer.log("TokenStorage: getToken() is $token");
    return token;
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }
}
