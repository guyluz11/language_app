import 'dart:collection';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:word_link/domain/objects/cards_releated/collection_object.dart';
import 'package:word_link/domain/objects/json_helper_object.dart';
import 'package:word_link/domain/objects/results_releasted/answers_collection_object.dart';

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

  Map<String, dynamic>? getMap(PreferenceKeys key);

  List<CollectionObject>? getCardsCollectionObject(PreferenceKeys key);

  HashMap<String, AnswersCollectionObject>? getAnswersCollectionObject(
    PreferenceKeys key,
  );

  void remove(PreferenceKeys key);

  Future setString(PreferenceKeys key, String value);

  Future setInt(PreferenceKeys key, int value);

  Future setBool(PreferenceKeys key, {required bool value});

  Future setDuration(PreferenceKeys key, Duration value);

  Future setDateTime(PreferenceKeys key, DateTime value);

  Future setStringList(PreferenceKeys key, List<String> value);

  Future setMap(
    PreferenceKeys key,
    HashMap<String, JsonHelperObject> hashMap,
  );

  Future setCardsCollectionObject(
    PreferenceKeys key,
    List<CollectionObject> value,
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
