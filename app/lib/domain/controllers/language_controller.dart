import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'package:word_link/domain/objects/cards_related/collection_object.dart';

part 'package:word_link/infrastructure/language_repository.dart';

abstract class LanguageController {
  static LanguageController? _instance;

  static LanguageController get instance => _instance ??= _LanguageRepository();

  Future<CollectionObject> getMostUsedWords({
    required LanguageEnum language,
    int numberOfWords = 5,
  });
}
