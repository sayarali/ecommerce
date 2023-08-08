import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums/preferences_key_enum.dart';

class SharedManager {
  static final SharedManager _instance = SharedManager._init();
  SharedPreferences _preferences;
  static SharedManager get instance => _instance;

  SharedManager._init() {
    SharedPreferences.getInstance().then((value) => _preferences = value);
  }

  static preferencesInit() async {
    _instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences.clear();
  }

  Future<void> setStringValue(PreferencesKeys key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  Future<void> setBoolValue(PreferencesKeys key, bool value) async {
    await _preferences.setBool(key.toString(), value);
  }

  Future<void> setStringListValue(
      PreferencesKeys key, List<String> value) async {
    await _preferences.setStringList(key.toString(), value);
  }

  String getStringValue(PreferencesKeys key) =>
      _preferences.getString(key.toString());
  bool getBoolValue(PreferencesKeys key) =>
      _preferences.getBool(key.toString());
  List<String> getStringListValue(PreferencesKeys key) =>
      _preferences.getStringList(key.toString());
}
