import 'dart:convert';

import 'package:shemanit/core/errors/exceptions.dart';
import 'package:shemanit/core/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Secure storage interface
abstract class SecureStorage {
  /// Store sensitive data
  Future<void> store(String key, String value);

  /// Retrieve sensitive data
  Future<String?> retrieve(String key);

  /// Delete sensitive data
  Future<void> delete(String key);

  /// Check if key exists
  Future<bool> containsKey(String key);

  /// Clear all stored data
  Future<void> clear();
}

@Singleton(as: SecureStorage)
class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;
  static const String _securePrefix = 'SECURE_';

  @override
  Future<void> store(String key, String value) async {
    try {
      // In production, you would use flutter_secure_storage
      // For now, we'll use SharedPreferences with encoding
      final encodedValue = base64Encode(utf8.encode(value));
      await _sharedPreferences.setString(_securePrefix + key, encodedValue);
      Logger.debug('Secure data stored for key: $key');
    } catch (e) {
      Logger.error('Error storing secure data', e);
      throw const CacheException(message: 'Failed to store secure data');
    }
  }

  @override
  Future<String?> retrieve(String key) async {
    try {
      final encodedValue = _sharedPreferences.getString(_securePrefix + key);
      if (encodedValue == null) return null;

      final decodedValue = utf8.decode(base64Decode(encodedValue));
      Logger.debug('Secure data retrieved for key: $key');
      return decodedValue;
    } catch (e) {
      Logger.error('Error retrieving secure data', e);
      throw const CacheException(message: 'Failed to retrieve secure data');
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await _sharedPreferences.remove(_securePrefix + key);
      Logger.debug('Secure data deleted for key: $key');
    } catch (e) {
      Logger.error('Error deleting secure data', e);
      throw const CacheException(message: 'Failed to delete secure data');
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      return _sharedPreferences.containsKey(_securePrefix + key);
    } catch (e) {
      Logger.error('Error checking secure key existence', e);
      return false;
    }
  }

  @override
  Future<void> clear() async {
    try {
      final keys = _sharedPreferences
          .getKeys()
          .where((key) => key.startsWith(_securePrefix))
          .toList();

      for (final key in keys) {
        await _sharedPreferences.remove(key);
      }

      Logger.debug('All secure data cleared');
    } catch (e) {
      Logger.error('Error clearing secure data', e);
      throw const CacheException(message: 'Failed to clear secure data');
    }
  }
}
