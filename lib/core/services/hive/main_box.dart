import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my/core/helper/helper_constant.dart';
import 'package:my/core/utils/constants/network_constants.dart';
import 'package:my/core/utils/typedefs.dart';

enum ActiveTheme {
  light(ThemeMode.light),
  dark(ThemeMode.dark),
  system(ThemeMode.system);

  final ThemeMode mode;

  const ActiveTheme(this.mode);
}

class _CacheEntry {
  final dynamic value;
  final DateTime? expiry;
  final bool canExpired;

  _CacheEntry(this.value, Duration? ttl, {this.canExpired = true})
    : expiry = canExpired
          ? null
          : DateTime.now().add(
              ttl ?? NetworkConstants.defaultDataCachedDuration,
            );
  bool get isExpired => !canExpired ? false : DateTime.now().isAfter(expiry!);
}

class MainBoxStorage<T> {
  MainBoxStorage({this.fromJson, this.toJson});

  // final String _key;
  final FromJsonFunction<T>? fromJson;
  final ToJsonFunction<T>? toJson;
  static const _firstTimerKey = 'is-user-first-timer';

  static late Box? mainBox;
  static final _boxName = HelperConstants.boxName;

  static Future<void> initHive(String prefixBox) async {
    await Hive.initFlutter();
    mainBox = await Hive.openBox("$prefixBox$_boxName");
  }

  Future<void> saveMapData({
    required String key,
    required T data,
    Duration? ttl,
    bool canExpired = true,
  }) async {
    final encodedData = jsonEncode(toJson!(data));
    await mainBox?.put(
      key,
      _CacheEntry(encodedData, ttl, canExpired: canExpired),
    );
  }

  Future<T?> loadMapData(String key) async {
    try {
      final _CacheEntry storedData = mainBox?.get(key);
      if (storedData.isExpired) {
        await invalidateOrClearData(key);
        return null;
      }
      if (storedData.value != null) {
        final decodedData =
            jsonDecode(storedData.value) as Map<String, dynamic>;
        return fromJson!(decodedData);
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<void> invalidateOrClearData(String key) async {
    await mainBox?.delete(key);
  }

  Future<void> deleteAll() async {
    /// Clear the box
    mainBox?.clear();
  }

  bool isFirstTime() => mainBox?.get(_firstTimerKey) ?? true;

  Future<void> cacheFirstTimer() async {
    await mainBox?.put(_firstTimerKey, false);
  }
}



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// // Types pour la sérialisation
// typedef FromJsonFunction<T> = T Function(Map<String, dynamic> json);
// typedef ToJsonFunction<T> = Map<String, dynamic> Function(T object);

// enum ActiveTheme {
//   light(ThemeMode.light),
//   dark(ThemeMode.dark),
//   system(ThemeMode.system);

//   final ThemeMode mode;
//   const ActiveTheme(this.mode);
// }

// class CacheEntry {
//   final String value;
//   final DateTime? expiry;

//   CacheEntry(this.value, Duration? ttl)
//       : expiry = ttl != null ? DateTime.now().add(ttl) : null;

//   bool get isExpired => expiry?.isBefore(DateTime.now()) ?? false;
// }

// // Interface pour faciliter les tests
// abstract class StorageInterface<T> {
//   Future<void> save(String key, T data, {Duration? ttl});
//   Future<T?> load(String key);
//   Future<void> delete(String key);
//   Future<void> clear();
// }

// class MainBoxStorage<T> implements StorageInterface<T> {
//   final Box _box;
//   final FromJsonFunction<T>? fromJson;
//   final ToJsonFunction<T>? toJson;
//   final Duration? defaultTtl;

//   MainBoxStorage({
//     required Box box,
//     this.fromJson,
//     this.toJson,
//     this.defaultTtl,
//   }) : _box = box;

//   // Factory pour l'initialisation
//   static Future<MainBoxStorage<T>> create<T>({
//     required String boxName,
//     FromJsonFunction<T>? fromJson,
//     ToJsonFunction<T>? toJson,
//     Duration? defaultTtl,
//   }) async {
//     final box = await Hive.openBox(boxName);
//     return MainBoxStorage<T>(
//       box: box,
//       fromJson: fromJson,
//       toJson: toJson,
//       defaultTtl: defaultTtl,
//     );
//   }

//   @override
//   Future<void> save(String key, T data, {Duration? ttl}) async {
//     try {
//       final jsonData = toJson?.call(data) ?? data as Map<String, dynamic>;
//       final encodedData = jsonEncode(jsonData);
//       final entry = CacheEntry(encodedData, ttl ?? defaultTtl);
//       await _box.put(key, entry);
//     } catch (e) {
//       throw StorageException('Failed to save data for key: $key', e);
//     }
//   }

//   @override
//   Future<T?> load(String key) async {
//     try {
//       final entry = _box.get(key) as CacheEntry?;
      
//       if (entry == null) return null;
      
//       if (entry.isExpired) {
//         await delete(key);
//         return null;
//       }

//       final decodedData = jsonDecode(entry.value) as Map<String, dynamic>;
//       return fromJson?.call(decodedData) ?? decodedData as T;
//     } catch (e) {
//       throw StorageException('Failed to load data for key: $key', e);
//     }
//   }

//   @override
//   Future<void> delete(String key) async {
//     try {
//       await _box.delete(key);
//     } catch (e) {
//       throw StorageException('Failed to delete data for key: $key', e);
//     }
//   }

//   @override
//   Future<void> clear() async {
//     try {
//       await _box.clear();
//     } catch (e) {
//       throw StorageException('Failed to clear storage', e);
//     }
//   }

//   // Méthodes utilitaires
//   bool containsKey(String key) => _box.containsKey(key);
  
//   List<String> get keys => _box.keys.cast<String>().toList();
  
//   int get length => _box.length;

//   // Nettoyage des entrées expirées
//   Future<int> cleanExpired() async {
//     int cleaned = 0;
//     final keysToDelete = <String>[];
    
//     for (final key in _box.keys) {
//       final entry = _box.get(key) as CacheEntry?;
//       if (entry?.isExpired == true) {
//         keysToDelete.add(key as String);
//       }
//     }
    
//     for (final key in keysToDelete) {
//       await delete(key);
//       cleaned++;
//     }
    
//     return cleaned;
//   }
// }

// // Classe séparée pour la logique métier spécifique
// class AppPreferences {
//   static const _firstTimeKey = 'is_first_time';
//   static const _themeKey = 'active_theme';
  
//   final StorageInterface<Map<String, dynamic>> _storage;
  
//   AppPreferences(this._storage);
  
//   Future<bool> isFirstTime() async {
//     final result = await _storage.load(_firstTimeKey);
//     return result?['value'] as bool? ?? true;
//   }
  
//   Future<void> setNotFirstTime() async {
//     await _storage.save(_firstTimeKey, {'value': false});
//   }
  
//   Future<ActiveTheme> getTheme() async {
//     final result = await _storage.load(_themeKey);
//     final themeName = result?['theme'] as String?;
//     return ActiveTheme.values.firstWhere(
//       (theme) => theme.name == themeName,
//       orElse: () => ActiveTheme.system,
//     );
//   }
  
//   Future<void> setTheme(ActiveTheme theme) async {
//     await _storage.save(_themeKey, {'theme': theme.name});
//   }
// }

// // Exception personnalisée
// class StorageException implements Exception {
//   final String message;
//   final dynamic cause;
  
//   StorageException(this.message, [this.cause]);
  
//   @override
//   String toString() => 'StorageException: $message${cause != null ? ' (caused by: $cause)' : ''}';
// }

// // Exemple d'utilisation
// /*
// // Initialisation
// final userStorage = await MainBoxStorage.create<User>(
//   boxName: 'users',
//   fromJson: User.fromJson,
//   toJson: (user) => user.toJson(),
//   defaultTtl: Duration(hours: 24),
// );

// final preferences = AppPreferences(
//   await MainBoxStorage.create<Map<String, dynamic>>(boxName: 'preferences')
// );

// // Usage
// await userStorage.save('current_user', user, ttl: Duration(hours: 1));
// final cachedUser = await userStorage.load('current_user');

// if (await preferences.isFirstTime()) {
//   // Logique pour premier démarrage
//   await preferences.setNotFirstTime();
// }
// */
