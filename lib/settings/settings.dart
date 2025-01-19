import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'persistence/local_storage_settings_persistence.dart';
import 'persistence/settings_persistence.dart';

/// An class that holds settings like [playerName] or [musicOn],
/// and saves them to an injected persistence store.
class SettingsController {
  static final _log = Logger('SettingsController');

  /// The persistence store that is used to save settings.
  final SettingsPersistence _store;

  /// Whether or not the sound effects (sfx) are on.
  ValueNotifier<bool> soundsOn = ValueNotifier(true);

  /// Whether or not the sound effects (sfx) are on.
  ValueNotifier<bool> vibrationsOn = ValueNotifier(true);

  /// Whether or not the user has seen the how to play dialog.
  ValueNotifier<bool> hasSeenHowToPlay = ValueNotifier(false);

  /// Creates a new instance of [SettingsController] backed by [store].
  ///
  /// By default, settings are persisted using [LocalStorageSettingsPersistence]
  /// (i.e. NSUserDefaults on iOS, SharedPreferences on Android or
  /// local storage on the web).
  SettingsController({SettingsPersistence? store}) : _store = store ?? LocalStorageSettingsPersistence() {
    _loadStateFromPersistence();
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _store.saveSoundsOn(soundsOn.value);
  }

  void toggleVibrations() {
    vibrationsOn.value = !vibrationsOn.value;
    _store.saveVibrationsOn(vibrationsOn.value);
  }

  void setHasSeenHowToPlay() {
    hasSeenHowToPlay.value = true;
    _store.saveHasSeenHowToPlay(true);
  }

  /// Asynchronously loads values from the injected persistence store.
  Future<void> _loadStateFromPersistence() async {
    final loadedValues = await Future.wait([
      _store.getSoundsOn(defaultValue: true).then((value) => soundsOn.value = value),
      _store.getVibrationsOn(defaultValue: true).then((value) => vibrationsOn.value = value),
      _store.getHasSeenHowToPlay(defaultValue: false).then((value) => hasSeenHowToPlay.value = value),
    ]);

    _log.fine(() => 'Loaded settings: $loadedValues');
  }
}
