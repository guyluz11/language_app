import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'package:word_link/domain/objects/json_helper_object.dart';

class CollectionObject extends JsonHelperObject {
  CollectionObject({
    required this.name,
    this.cards = const [],
    this.uniqueId = '-1',
  }) {
    if (uniqueId == '-1') {
      uniqueId = RandomIdController.instance.getUniqueId();
    }
  }

  // Factory method to create a CardsCollectionObject from JSON
  factory CollectionObject.fromJson(Map<String, dynamic> json) {
    return CollectionObject(
      name: json['name'] as String,
      cards: (json['cards'] as List<dynamic>)
          .map(
            (cardJson) => CardObject.fromJson(cardJson as Map<String, dynamic>),
          )
          .toList(),
      uniqueId: json['uniqueId'] as String,
    );
  }

  String name;
  List<CardObject> cards;
  late String uniqueId;

  // Method to convert a CardsCollectionObject to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cards': cards.map((card) => card.toJson()).toList(),
      'uniqueId': uniqueId,
    };
  }
}
