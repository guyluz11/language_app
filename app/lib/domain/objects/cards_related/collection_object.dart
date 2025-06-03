import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'package:word_link/domain/objects/json_helper_object.dart';

class CollectionObject extends JsonHelperObject {
  CollectionObject({
    required this.name,
    List<CardObject> cardsTemp = const [],
    this.uniqueId = '-1',
    this.knows,
    this.learning,
  }) {
    cards = List.of(cardsTemp);
    if (uniqueId == '-1') {
      uniqueId = RandomIdController.instance.getUniqueId();
    }
  }

  // Factory method to create a CardsCollectionObject from JSON
  factory CollectionObject.fromJson(Map<String, dynamic> json) {
    return CollectionObject(
      name: json['name'] as String,
      cardsTemp: (json['cards'] as List<dynamic>)
          .map(
            (cardJson) => CardObject.fromJson(cardJson as Map<String, dynamic>),
          )
          .toList(),
      uniqueId: json['uniqueId'] as String,
      knows: LanguageEnum.fromString(json['knows'] as String? ?? ''),
      learning: LanguageEnum.fromString(json['learning'] as String? ?? ''),
    );
  }

  String name;
  late List<CardObject> cards;
  late String uniqueId;
  LanguageEnum? knows;
  LanguageEnum? learning;

  // Method to convert a CardsCollectionObject to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cards': cards.map((card) => card.toJson()).toList(),
      'uniqueId': uniqueId,
      'knows': knows,
      'learning': learning,
    };
  }
}
