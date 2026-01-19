import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  late SharedPreferences _prefs;
  StorageService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool?> write({required String key, required dynamic value}) async {
    try {
      if (value is bool) return await _prefs.setBool(key, value);
      if (value is String) return await _prefs.setString(key, value);
      if (value is int) return await _prefs.setInt(key, value);
      if (value is double) return await _prefs.setDouble(key, value);
      if (value is List<String>) return await _prefs.setStringList(key, value);
      return null;
    } catch (e) {
      throw Exception('Failed to save data: $e');
    }
  }

  dynamic read({required String key}) => _prefs.get(key);

  T? readTypedData<T>({required String key}) => _prefs.get(key) as T?;

  Future<bool> remove({required String key}) async => await _prefs.remove(key);

  Future<bool> clearAll() async => await _prefs.clear();
}
