import 'dart:collection';

import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/results_releasted/answers_collection_object.dart';

/// Answers for all of the collections
class AnswersCollectionsObject {
  /// Answers by collection id
  static HashMap<String, AnswersCollectionObject> _answers = HashMap();

  /// Initialize `_customCards` from persistent storage
  static void init() =>
      _answers = PreferencesController.instance.getAnswersCollectionObject(
            PreferenceKeys.customCollections,
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
  static Future<void> addCollection(
    String key,
    AnswersCollectionObject collection,
  ) async {
    _answers[key] = collection;

    // Save updated data to persistent storage
    await PreferencesController.instance.setMap(
      PreferenceKeys.customCollections,
      _answers,
    );
  }

  /// Get all collections
  static HashMap<String, AnswersCollectionObject> getCollections() {
    return _answers;
  }
}
