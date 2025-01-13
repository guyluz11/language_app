import 'package:word_link/domain/objects/card_object.dart';

class CardsCollectionObject {
  CardsCollectionObject({
    required this.name,
    this.cards = const [],
  });

  String name;
  List<CardObject> cards;

  // Factory method to create a CardsCollectionObject from JSON
  factory CardsCollectionObject.fromJson(Map<String, dynamic> json) {
    return CardsCollectionObject(
      name: json['name'] as String,
      cards: (json['cards'] as List<dynamic>)
          .map((cardJson) =>
              CardObject.fromJson(cardJson as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method to convert a CardsCollectionObject to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cards': cards.map((card) => card.toJson()).toList(),
    };
  }
}

class CollectionsManager {
  static List<CardsCollectionObject> customCards = [];
}
