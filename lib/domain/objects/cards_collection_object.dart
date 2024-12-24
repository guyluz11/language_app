import 'package:word_link/domain/objects/card_object.dart';

class CardsCollectionObject {
  CardsCollectionObject({
    required this.name,
    this.customCards = const [],
  });

  String name;
  List<CardObject> customCards;
}

class CollectionsManager {
  static List<CardsCollectionObject> customCards = [];
}
