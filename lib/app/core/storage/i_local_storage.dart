abstract class ILocalStorage {
  Future<String?> get(String key);

  Future<void> put(String key, String value);

  Future<bool> getBool(String key, [bool orDefault = false]);

  Future<void> setBool(String key, bool value);

  Future<void> delete(String key);

  Future<void> clear();
}
