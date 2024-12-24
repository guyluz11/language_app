import 'package:word_link/domain/objects/card_object.dart';

class CardsCollectionObject {
  CardsCollectionObject({
    required this.name,
    this.cards = const [],
  });

  String name;
  List<CardObject> cards;
}

class CollectionsManager {
  static List<CardsCollectionObject> customCards = [];
}
