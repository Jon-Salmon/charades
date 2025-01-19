import 'settings_persistence.dart';

/// An in-memory implementation of [SettingsPersistence].
/// Useful for testing.
class MemoryOnlySettingsPersistence implements SettingsPersistence {
  bool soundsOn = true;
  bool vibrationsOn = true;

  @override
  Future<bool> getSoundsOn({required bool defaultValue}) async => soundsOn;

  @override
  Future<void> saveSoundsOn(bool value) async => soundsOn = value;

  @override
  Future<bool> getVibrationsOn({required bool defaultValue}) async => vibrationsOn;

  @override
  Future<void> saveVibrationsOn(bool value) async => vibrationsOn = value;

  @override
  Future<bool> getHasSeenHowToPlay({required bool defaultValue}) async => false;

  @override
  Future<void> saveHasSeenHowToPlay(bool value) async {}
}
