/// An interface of persistence stores for settings.
///
/// Implementations can range from simple in-memory storage through
/// local preferences to cloud-based solutions.
abstract class SettingsPersistence {
  Future<bool> getSoundsOn({required bool defaultValue});

  Future<void> saveSoundsOn(bool value);

  Future<bool> getVibrationsOn({required bool defaultValue});

  Future<void> saveVibrationsOn(bool value);

  Future<bool> getHasSeenHowToPlay({required bool defaultValue});

  Future<void> saveHasSeenHowToPlay(bool value);
}
