import 'dart:convert';

import 'package:ddd_flutter_app/core/errors/exceptions.dart';
import 'package:ddd_flutter_app/core/utils/logger.dart';
import 'package:ddd_flutter_app/features/counter/infrastructure/models/counter_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local data source for counter persistence
abstract class CounterLocalDataSource {
  /// Get cached counter
  Future<CounterModel> getCachedCounter();

  /// Cache counter
  Future<void> cacheCounter(CounterModel counter);

  /// Get counter history
  Future<List<CounterModel>> getCachedCounterHistory();

  /// Add counter to history
  Future<void> addToHistory(CounterModel counter);

  /// Clear all cached data
  Future<void> clearCache();
}

@Singleton(as: CounterLocalDataSource)
class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  CounterLocalDataSourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static const String _counterKey = 'CACHED_COUNTER';
  static const String _historyKey = 'COUNTER_HISTORY';

  @override
  Future<CounterModel> getCachedCounter() async {
    try {
      final jsonString = _sharedPreferences.getString(_counterKey);

      if (jsonString == null) {
        // Return default counter if none exists
        final defaultCounter = CounterModel(
          id: 'default',
          value: 0,
          createdAt: DateTime.now(),
        );
        await cacheCounter(defaultCounter);
        return defaultCounter;
      }

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return CounterModel.fromJson(jsonMap);
    } catch (e) {
      Logger.error('Error getting cached counter', e);
      throw const CacheException(message: 'Failed to get cached counter');
    }
  }

  @override
  Future<void> cacheCounter(CounterModel counter) async {
    try {
      final jsonString = json.encode(counter.toJson());
      await _sharedPreferences.setString(_counterKey, jsonString);
      Logger.debug('Counter cached successfully');
    } catch (e) {
      Logger.error('Error caching counter', e);
      throw const CacheException(message: 'Failed to cache counter');
    }
  }

  @override
  Future<List<CounterModel>> getCachedCounterHistory() async {
    try {
      final jsonString = _sharedPreferences.getString(_historyKey);

      if (jsonString == null) {
        return [];
      }

      final jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => CounterModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Logger.error('Error getting counter history', e);
      throw const CacheException(message: 'Failed to get counter history');
    }
  }

  @override
  Future<void> addToHistory(CounterModel counter) async {
    try {
      final currentHistory = await getCachedCounterHistory();
      currentHistory.add(counter);

      // Keep only last 100 entries
      if (currentHistory.length > 100) {
        currentHistory.removeRange(0, currentHistory.length - 100);
      }

      final jsonString = json.encode(
        currentHistory.map((model) => model.toJson()).toList(),
      );
      await _sharedPreferences.setString(_historyKey, jsonString);
      Logger.debug('Counter added to history');
    } catch (e) {
      Logger.error('Error adding to counter history', e);
      throw const CacheException(message: 'Failed to add to counter history');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _sharedPreferences.remove(_counterKey);
      await _sharedPreferences.remove(_historyKey);
      Logger.debug('Counter cache cleared');
    } catch (e) {
      Logger.error('Error clearing counter cache', e);
      throw const CacheException(message: 'Failed to clear counter cache');
    }
  }
}
