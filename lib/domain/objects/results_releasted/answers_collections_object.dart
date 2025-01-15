import 'dart:collection';

import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/results_releasted/answers_collection_object.dart';

/// Answers for all of the collections
class AnswersCollectionsObject {
  static HashMap<String, AnswersCollectionObject> _customCards = HashMap();

  /// Initialize `_customCards` from persistent storage
  static void init() =>
      _customCards = PreferencesController.instance.getAnswersCollectionObject(
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
    _customCards[key] = collection;

    // Save updated data to persistent storage
    await PreferencesController.instance.setMap(
      PreferenceKeys.customCollections,
      _customCards,
    );
  }

  /// Get all collections
  static HashMap<String, AnswersCollectionObject> getCollections() {
    return _customCards;
  }
}
