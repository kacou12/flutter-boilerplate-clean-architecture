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
  MainBoxStorage(
    this._key, {
    required this.fromJson,
    required this.toJson,
  });
  final String _key;
  final FromJsonFunction<T> fromJson;
  final ToJsonFunction<T> toJson;

  static late Box? mainBox;
  static final _boxName = HelperConstants.boxName;

  static Future<void> initHive(String prefixBox) async {
    await Hive.initFlutter();
    mainBox = await Hive.openBox("$prefixBox$_boxName");
  }

  Future<void> saveData(T data) async {
    final encodedData = jsonEncode(toJson(data));
    await mainBox?.put(_key, encodedData);
  }

  Future<T?> loadData() async {
    try {
      final storedData = mainBox?.get(_key);
      if (storedData != null && storedData.isNotEmpty) {
        final decodedData = jsonDecode(storedData) as Map<String, dynamic>;
        return fromJson(decodedData);
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<void> clearData() async {
    await mainBox?.delete(_key);
  }

  Future<void> deleteAll() async {
    /// Clear the box
    mainBox?.clear();
  }
}
