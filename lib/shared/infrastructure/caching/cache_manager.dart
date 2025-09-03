import 'dart:convert';

import 'package:shemanit/core/constants/app_constants.dart';
import 'package:shemanit/core/errors/exceptions.dart';
import 'package:shemanit/core/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cache entry with expiration
class CacheEntry<T> {
  const CacheEntry({
    required this.data,
    required this.timestamp,
    this.ttl = AppConstants.cacheTimeout,
  });

  /// Create from JSON
  factory CacheEntry.fromJson(Map<String, dynamic> json) {
    return CacheEntry<T>(
      data: json['data'] as T,
      timestamp: DateTime.parse(json['timestamp'] as String),
      ttl: Duration(milliseconds: json['ttl'] as int),
    );
  }

  final T data;
  final DateTime timestamp;
  final Duration ttl;

  /// Check if cache entry is expired
  bool get isExpired => DateTime.now().difference(timestamp) > ttl;

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'data': data,
        'timestamp': timestamp.toIso8601String(),
        'ttl': ttl.inMilliseconds,
      };
}

/// Cache manager interface
abstract class CacheManager {
  /// Store data in cache
  Future<void> store<T>(String key, T data, {Duration? ttl});

  /// Retrieve data from cache
  Future<T?> retrieve<T>(String key);

  /// Remove data from cache
  Future<void> remove(String key);

  /// Check if key exists and is not expired
  Future<bool> contains(String key);

  /// Clear all cache
  Future<void> clear();

  /// Clear expired entries
  Future<void> clearExpired();
}

@Singleton(as: CacheManager)
class CacheManagerImpl implements CacheManager {
  CacheManagerImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;
  static const String _cachePrefix = 'CACHE_';

  @override
  Future<void> store<T>(String key, T data, {Duration? ttl}) async {
    try {
      final cacheEntry = CacheEntry<T>(
        data: data,
        timestamp: DateTime.now(),
        ttl: ttl ?? AppConstants.cacheTimeout,
      );

      final jsonString = json.encode(cacheEntry.toJson());
      await _sharedPreferences.setString(_cachePrefix + key, jsonString);

      Logger.debug('Data cached for key: $key');
    } catch (e) {
      Logger.error('Error caching data', e);
      throw const CacheException(message: 'Failed to cache data');
    }
  }

  @override
  Future<T?> retrieve<T>(String key) async {
    try {
      final jsonString = _sharedPreferences.getString(_cachePrefix + key);
      if (jsonString == null) return null;

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      final cacheEntry = CacheEntry<T>.fromJson(jsonMap);

      if (cacheEntry.isExpired) {
        await remove(key);
        Logger.debug('Cache entry expired and removed: $key');
        return null;
      }

      Logger.debug('Data retrieved from cache: $key');
      return cacheEntry.data;
    } catch (e) {
      Logger.error('Error retrieving cached data', e);
      throw const CacheException(message: 'Failed to retrieve cached data');
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      await _sharedPreferences.remove(_cachePrefix + key);
      Logger.debug('Cache entry removed: $key');
    } catch (e) {
      Logger.error('Error removing cached data', e);
      throw const CacheException(message: 'Failed to remove cached data');
    }
  }

  @override
  Future<bool> contains(String key) async {
    try {
      final jsonString = _sharedPreferences.getString(_cachePrefix + key);
      if (jsonString == null) return false;

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      final cacheEntry = CacheEntry<dynamic>.fromJson(jsonMap);

      if (cacheEntry.isExpired) {
        await remove(key);
        return false;
      }

      return true;
    } catch (e) {
      Logger.error('Error checking cache existence', e);
      return false;
    }
  }

  @override
  Future<void> clear() async {
    try {
      final keys = _sharedPreferences
          .getKeys()
          .where((key) => key.startsWith(_cachePrefix))
          .toList();

      for (final key in keys) {
        await _sharedPreferences.remove(key);
      }

      Logger.debug('All cache cleared');
    } catch (e) {
      Logger.error('Error clearing cache', e);
      throw const CacheException(message: 'Failed to clear cache');
    }
  }

  @override
  Future<void> clearExpired() async {
    try {
      final keys = _sharedPreferences
          .getKeys()
          .where((key) => key.startsWith(_cachePrefix))
          .toList();

      var removedCount = 0;
      for (final key in keys) {
        final jsonString = _sharedPreferences.getString(key);
        if (jsonString == null) continue;

        try {
          final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
          final cacheEntry = CacheEntry<dynamic>.fromJson(jsonMap);

          if (cacheEntry.isExpired) {
            await _sharedPreferences.remove(key);
            removedCount++;
          }
        } catch (e) {
          // Remove corrupted entries
          await _sharedPreferences.remove(key);
          removedCount++;
        }
      }

      Logger.debug('Cleared $removedCount expired cache entries');
    } catch (e) {
      Logger.error('Error clearing expired cache', e);
      throw const CacheException(message: 'Failed to clear expired cache');
    }
  }
}
