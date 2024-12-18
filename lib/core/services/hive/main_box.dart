import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my/core/helper/helper_constant.dart';
import 'package:my/core/utils/typedefs.dart';

enum ActiveTheme {
  light(ThemeMode.light),
  dark(ThemeMode.dark),
  system(ThemeMode.system);

  final ThemeMode mode;

  const ActiveTheme(this.mode);
}

class MainBoxStorage<T> {
  MainBoxStorage({
    this.fromJson,
    this.toJson,
  });

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

  Future<void> saveMapData({required String key, required T data}) async {
    final encodedData = jsonEncode(toJson!(data));
    await mainBox?.put(key, encodedData);
  }

  Future<T?> loadMapData(String key) async {
    try {
      final storedData = mainBox?.get(key);
      if (storedData != null && storedData.isNotEmpty) {
        final decodedData = jsonDecode(storedData) as Map<String, dynamic>;
        return fromJson!(decodedData);
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<void> clearData(String key) async {
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
