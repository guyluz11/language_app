part of 'package:word_link/domain/controllers/preferences_controller.dart';

class _PreferencesRepository extends PreferencesController {
  late SharedPreferences preferences;

  @override
  Future init() async => preferences = await SharedPreferences.getInstance();

  @override
  String? getString(PreferenceKeys key) => preferences.getString(key.name);

  @override
  int? getInt(PreferenceKeys key) => preferences.getInt(key.name);

  @override
  bool? getBool(PreferenceKeys key) => preferences.getBool(key.name);

  @override
  Duration? getDuration(PreferenceKeys key) {
    final int? milliseconds = preferences.getInt(key.name);
    return milliseconds == null ? null : Duration(milliseconds: milliseconds);
  }

  @override
  DateTime? getDateTime(PreferenceKeys key) {
    final int? milliseconds = preferences.getInt(key.name);
    return milliseconds == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  @override
  List<String>? getStringList(PreferenceKeys key) =>
      preferences.getStringList(key.name);

  @override
  List<CardsCollectionObject>? getCardsCollectionObject(PreferenceKeys key) {
    // Get the list of JSON strings
    final jsonStringList = getStringList(key);

    if (jsonStringList == null) {
      // Return an empty list if no data is found
      return [];
    }

    // Convert the list of JSON strings back to a list of objects
    return jsonStringList.map((jsonString) {
      final Map<String, dynamic> jsonData =
          json.decode(jsonString) as Map<String, dynamic>;
      return CardsCollectionObject.fromJson(jsonData);
    }).toList();
  }

  @override
  void remove(PreferenceKeys key) => preferences.remove(key.name);

  @override
  Future setString(PreferenceKeys key, String value) =>
      preferences.setString(key.name, value);

  @override
  Future setInt(PreferenceKeys key, int value) =>
      preferences.setInt(key.name, value);

  @override
  Future setBool(PreferenceKeys key, {required bool value}) =>
      preferences.setBool(key.name, value);

  @override
  Future setDuration(PreferenceKeys key, Duration value) =>
      preferences.setInt(key.name, value.inMilliseconds);

  @override
  Future setDateTime(PreferenceKeys key, DateTime value) =>
      preferences.setInt(key.name, value.millisecondsSinceEpoch);

  @override
  Future setStringList(PreferenceKeys key, List<String> value) =>
      preferences.setStringList(key.name, value);

  @override
  Future setCardsCollectionObject(
    PreferenceKeys key,
    List<CardsCollectionObject> collections,
  ) async {
    // Convert the list of objects to a list of JSON strings
    final List<String> jsonStringList = collections.map((collection) {
      return json.encode(collection.toJson());
    }).toList();

    // Save the list of JSON strings
    await setStringList(key, jsonStringList);
  }
}
