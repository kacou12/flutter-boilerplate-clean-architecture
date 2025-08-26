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
      if (storedData.canExpired &&
          DateTime.now().isAfter(
            DateTime.parse(storedData.expiry!.toIso8601String()),
          )) {
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
