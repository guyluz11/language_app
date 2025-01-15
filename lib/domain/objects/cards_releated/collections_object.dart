import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/cards_releated/collection_object.dart';

class CollectionsObject {
  static List<CollectionObject> _customCards = [];

  static void init() =>
      _customCards = PreferencesController.instance.getCardsCollectionObject(
            PreferenceKeys.customCollections,
          ) ??
          [];

  static Future addCollection(CollectionObject collection) async {
    _customCards.add(collection);

    await PreferencesController.instance.setCardsCollectionObject(
      PreferenceKeys.customCollections,
      _customCards,
    );
  }

  static List<CollectionObject> getCollections() => _customCards;
}
