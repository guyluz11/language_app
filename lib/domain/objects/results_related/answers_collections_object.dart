import 'dart:collection';

import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/results_related/answers_collection_object.dart';

/// Answers for all of the collections
class AnswersCollectionsObject {
  /// Answers by collection id
  static HashMap<String, AnswersCollectionObject> _answers = HashMap();

  /// Initialize `_customCards` from persistent storage
  static void init() => _answers = _getAnswersCollectionFromPreference(
        PreferenceKeys.answersCollections,
      ) ??
      HashMap();

  /// Factory method to create an `AnswersCollectionsObject` from JSON
  static HashMap<String, AnswersCollectionObject> fromJson(
    Map<String, dynamic> json,
  ) {
    return HashMap<String, AnswersCollectionObject>.from(
      (json['resultsPerCollection'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          AnswersCollectionObject.fromJson(value as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// Add a collection and persist it
  static Future<void> addCollection(AnswersCollectionObject collection) async {
    _answers[collection.uniqueId] = collection;

    // Save updated data to persistent storage
    await PreferencesController.instance.setMap(
      PreferenceKeys.answersCollections,
      _answers,
    );
  }

  /// Get all collections
  static HashMap<String, AnswersCollectionObject> getCollections() => _answers;

  static HashMap<String, AnswersCollectionObject>?
      _getAnswersCollectionFromPreference(
    PreferenceKeys key,
  ) {
    final Map<String, dynamic>? mapFromDb =
        PreferencesController.instance.getMap(key);
    if (mapFromDb == null) {
      return null;
    }

    return HashMap<String, AnswersCollectionObject>.from(
      mapFromDb.map(
        (key, value) => MapEntry(
          key,
          AnswersCollectionObject.fromJson(value as Map<String, dynamic>),
        ),
      ),
    );
  }
}
