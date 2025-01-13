import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:word_link/domain/objects/cards_collection_object.dart';

part 'package:word_link/infrastructure/preferences_repository.dart';

abstract class PreferencesController {
  static PreferencesController? _instance;

  static PreferencesController get instance =>
      _instance ??= _PreferencesRepository();

  Future init();

  String? getString(PreferenceKeys key);

  int? getInt(PreferenceKeys key);

  bool? getBool(PreferenceKeys key);

  Duration? getDuration(PreferenceKeys key);

  DateTime? getDateTime(PreferenceKeys key);

  List<String>? getStringList(PreferenceKeys key);

  List<CardsCollectionObject>? getCardsCollectionObject(PreferenceKeys key);

  void remove(PreferenceKeys key);

  Future setString(PreferenceKeys key, String value);

  Future setInt(PreferenceKeys key, int value);

  Future setBool(PreferenceKeys key, {required bool value});

  Future setDuration(PreferenceKeys key, Duration value);

  Future setDateTime(PreferenceKeys key, DateTime value);

  Future setStringList(PreferenceKeys key, List<String> value);

  Future setCardsCollectionObject(
    PreferenceKeys key,
    List<CardsCollectionObject> collection,
  );
}

enum PreferenceKeys {
  loginCounter,
  isLockScreen,
  isSound,
  pausedTime,
  timerState,
  remainingTimerTime,
  freeText,
  tipType,
  sleepPermissionGranted,
  customCollections,
}
