import 'package:shared_preferences/shared_preferences.dart';

import 'settings_persistence.dart';

/// An implementation of [SettingsPersistence] that uses
/// `package:shared_preferences`.
class LocalStorageSettingsPersistence extends SettingsPersistence {
  final Future<SharedPreferences> instanceFuture = SharedPreferences.getInstance();

  @override
  Future<bool> getSoundsOn({required bool defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getBool('soundsOn') ?? defaultValue;
  }

  @override
  Future<void> saveSoundsOn(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('soundsOn', value);
  }

  @override
  Future<bool> getVibrationsOn({required bool defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getBool('vibrationsOn') ?? defaultValue;
  }

  @override
  Future<void> saveVibrationsOn(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('vibrationsOn', value);
  }
}
