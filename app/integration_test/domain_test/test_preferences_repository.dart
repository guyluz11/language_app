import 'dart:collection';

import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/json_helper_object.dart';

class TestPreferencesRepository extends PreferencesController {
  TestPreferencesRepository() {
    PreferencesController.instance = this;
  }

  @override
  bool? getBool(PreferenceKeys key) => null;

  @override
  DateTime? getDateTime(PreferenceKeys key) => null;

  @override
  Duration? getDuration(PreferenceKeys key) => null;

  @override
  int? getInt(PreferenceKeys key) => null;

  @override
  String? getString(PreferenceKeys key) => null;

  @override
  Future init() async {}

  @override
  void remove(PreferenceKeys key) {}

  @override
  Map<String, dynamic>? getMap(PreferenceKeys key) => null;

  @override
  List<String>? getStringList(PreferenceKeys key) => null;

  @override
  Future setMap(PreferenceKeys key, HashMap<String, JsonHelperObject> hashMap) async => null;
  @override
  Future setStringList(PreferenceKeys key, List<String> value) async => null;
  @override
  Future setBool(PreferenceKeys key, {required bool value}) async => null;

  @override
  Future setDateTime(PreferenceKeys key, DateTime value) async => null;

  @override
  Future setDuration(PreferenceKeys key, Duration value) async => null;

  @override
  Future setInt(PreferenceKeys key, int value)async => null;
  @override
  Future setString(PreferenceKeys key, String value) async => null;
}
