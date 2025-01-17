import 'dart:collection';

import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/cards_related/collection_object.dart';
import 'package:word_link/infrastructure/core/logger.dart';

class CollectionsObject {
  /// Custom collections mapped by their unique identifiers
  static HashMap<String, CollectionObject> _customCards = HashMap();

  /// Initialize `_customCards` from persistent storage
  static void init() => _customCards = _getCollectionsFromPreference(
        PreferenceKeys.customCollections,
      ) ??
      HashMap();

  /// Add a collection to `_customCards` and persist it
  static Future<void> addCollection(CollectionObject collection) async {
    _customCards[collection.uniqueId] = collection;

    // Save updated data to persistent storage
    await PreferencesController.instance.setMap(
      PreferenceKeys.customCollections,
      _customCards,
    );
  }

  /// Get all collections
  static HashMap<String, CollectionObject> getCollections() => _customCards;

  /// Get all collections
  static CollectionObject? getCollectionById(String id) => _customCards[id];

  /// Retrieve collections from persistent storage
  static HashMap<String, CollectionObject>? _getCollectionsFromPreference(
    PreferenceKeys key,
  ) {
    Map<String, dynamic>? mapFromDb;
    try {
      mapFromDb = PreferencesController.instance.getMap(key);
    } catch (e) {
      logger.w(
        '_getCollectionsFromPreference preferences for key $key is wrong type',
      );
    }
    if (mapFromDb == null) {
      return null;
    }

    return HashMap<String, CollectionObject>.from(
      mapFromDb.map(
        (key, value) => MapEntry(
          key,
          CollectionObject.fromJson(value as Map<String, dynamic>),
        ),
      ),
    );
  }
}
