import 'dart:async';

import 'package:lgpdjus/app/core/storage/i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSharedPreferences implements ILocalStorage {
  Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  LocalStorageSharedPreferences() {
    _init();
  }

  _init() async {
    _instance.complete(await SharedPreferences.getInstance());
  }

  @override
  Future<bool> hasKey(String key) =>
      _instance.future.then((preferences) => preferences.containsKey(key));

  @override
  Future<void> delete(String key) async {
    final shared = await _instance.future;
    await shared.remove(key);
  }

  @override
  Future<String?> get(String key) async {
    final shared = await _instance.future;
    return shared.getString(key);
  }

  @override
  Future<bool> getBool(String key, [bool orDefault = false]) async {
    final shared = await _instance.future;
    return shared.getBool(key) ?? orDefault;
  }

  @override
  Future<void> setBool(String key, bool value) async {
    final shared = await _instance.future;
    shared.setBool(key, value);
  }

  @override
  Future<void> put(String key, String value) async {
    final shared = await _instance.future;
    await shared.setString(key, value);
  }

  @override
  Future<void> clear() async {
    final shared = await _instance.future;
    await shared.clear();
    await shared.reload();
  }
}
