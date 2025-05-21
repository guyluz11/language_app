import 'package:map_tube/domain/controllers/controllers.dart';

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
  void setBool(PreferenceKeys key, {required bool value}) {}

  @override
  void setDateTime(PreferenceKeys key, DateTime value) {}

  @override
  void setDuration(PreferenceKeys key, Duration value) {}

  @override
  void setInt(PreferenceKeys key, int value) {}

  @override
  void setString(PreferenceKeys key, String value) {}
}
