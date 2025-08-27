import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my/core/core.dart';
import 'package:my/core/utils/constants/network_constants.dart';

typedef FromJsonFunction<T> = T Function(Map<String, dynamic> json);
typedef ToJsonFunction<T> = Map<String, dynamic> Function(T object);

enum ActiveTheme {
  light(ThemeMode.light),
  dark(ThemeMode.dark),
  system(ThemeMode.system);

  final ThemeMode mode;
  const ActiveTheme(this.mode);
}

class CacheEntry {
  final String value;

  final DateTime? expiry;

  CacheEntry(this.value, Duration? ttl)
    : expiry = ttl != null ? DateTime.now().add(ttl) : null;

  CacheEntry.fromJson(Map<String, dynamic> json)
    : value = json['value'],
      expiry = json['expiry'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['expiry'])
          : null;

  bool get isExpired => expiry?.isBefore(DateTime.now()) ?? false;

  Map<String, dynamic> toJson() => {
    'value': value,
    'expiry': expiry?.millisecondsSinceEpoch,
  };
}

abstract class StorageInterface<T> {
  Future<void> save({required String key, required T data, Duration? ttl});
  Future<T?> load(String key);
  Future<void> delete(String key);
  Future<void> clear();
}

class MainBoxStorage<T> implements StorageInterface<T> {
  final FromJsonFunction<T>? fromJson;
  final ToJsonFunction<T>? toJson;

  MainBoxStorage({this.fromJson, this.toJson});

  static final boxName = HelperConstants.boxName;
  static final Duration defaultTtl = NetworkConstants.defaultDataCachedDuration;

  static late Box box;

  static Future<void> initialize<T>(String boxName) async {
    await Hive.initFlutter();
    box = await Hive.openBox(boxName);
  }

  static Future<MainBoxStorage<T>> create<T>({
    FromJsonFunction<T>? fromJson,
    ToJsonFunction<T>? toJson,
  }) async {
    return MainBoxStorage<T>(fromJson: fromJson, toJson: toJson);
  }

  @override
  Future<void> save({
    required String key,
    required T data,
    Duration? ttl,
    bool hasExpiration = true,
  }) async {
    try {
      final jsonData = toJson?.call(data) ?? data as Map<String, dynamic>;
      final encodedData = jsonEncode(jsonData);

      final effectiveTtl = hasExpiration ? ttl : null;
      final entry = CacheEntry(encodedData, effectiveTtl);

      await box.put(key, entry.toJson());
    } catch (e) {
      throw StorageException('Failed to save data for key: $key', e);
    }
  }

  @override
  Future<T?> load(String key) async {
    try {
      // box.clear();
      final entryJson = box.get(key) as String?;

      if (entryJson == null) return null;

      final entry = CacheEntry.fromJson(jsonDecode(entryJson));

      if (entry.isExpired) {
        await delete(key);
        return null;
      }

      final decodedData = jsonDecode(entry.value) as Map<String, dynamic>;
      return fromJson?.call(decodedData);
    } catch (e) {
      throw StorageException('Failed to load data for key: $key', e);
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await box.delete(key);
    } catch (e) {
      throw StorageException('Failed to delete data for key: $key', e);
    }
  }

  @override
  Future<void> clear() async {
    try {
      await box.clear();
    } catch (e) {
      throw StorageException('Failed to clear storage', e);
    }
  }

  bool containsKey(String key) => box.containsKey(key);

  List<String> get keys => box.keys.cast<String>().toList();

  int get length => box.length;

  Future<int> cleanExpired() async {
    int cleaned = 0;
    final keysToDelete = <String>[];

    for (final key in box.keys) {
      final entry = box.get(key) as CacheEntry?;
      if (entry?.isExpired == true) {
        keysToDelete.add(key as String);
      }
    }

    for (final key in keysToDelete) {
      await delete(key);
      cleaned++;
    }

    return cleaned;
  }
}

class AppPreferences {
  static const _firstTimeKey = 'is_first_time';
  static const _themeKey = 'active_theme';

  final StorageInterface _storage;

  AppPreferences(this._storage);

  Future<bool> isFirstTime() async {
    final result = await _storage.load(_firstTimeKey);
    return result?['value'] as bool? ?? true;
  }

  Future<void> setNotFirstTime() async {
    await _storage.save(key: _firstTimeKey, data: {'value': false});
  }

  Future<ActiveTheme> getTheme() async {
    final result = await _storage.load(_themeKey);
    final themeName = result?['theme'] as String?;
    return ActiveTheme.values.firstWhere(
      (theme) => theme.name == themeName,
      orElse: () => ActiveTheme.system,
    );
  }

  Future<void> setTheme(ActiveTheme theme) async {
    await _storage.save(key: _themeKey, data: {'theme': theme.name});
  }
}

// Exemple d'utilisation
/*
// Initialisation
final userStorage = await MainBoxStorage.create<User>(
  boxName: 'users',
  fromJson: User.fromJson,
  toJson: (user) => user.toJson(),
  defaultTtl: Duration(hours: 24),
);

final preferences = AppPreferences(
  await MainBoxStorage.create<Map<String, dynamic>>(boxName: 'preferences')
);

// Usage
await userStorage.save('current_user', user, ttl: Duration(hours: 1));
final cachedUser = await userStorage.load('current_user');

if (await preferences.isFirstTime()) {
  // Logique pour premier démarrage
  await preferences.setNotFirstTime();
}
*/
