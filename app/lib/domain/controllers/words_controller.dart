import 'package:word_link/domain/objects/cards_related/collection_object.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'dart:math';

part 'package:word_link/infrastructure/words_repository.dart';


    abstract class WordsController {
    static WordsController? _instance;

    static WordsController get instance => _instance ??= _WordsRepository();

    CollectionObject generateCollection(String name);
   
}

