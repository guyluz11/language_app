import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'package:word_link/domain/objects/cards_related/collection_object.dart';
import 'package:word_link/domain/objects/cards_related/word_object.dart'
    show WordObject;
import 'package:word_link/domain/objects/language_enum.dart';
import 'package:word_link/infrastructure/core/logger.dart';

part 'package:word_link/infrastructure/language_repository.dart';

abstract class LanguageController {
  static LanguageController? _instance;

  static LanguageController get instance => _instance ??= _LanguageRepository();

  Future<CollectionObject> getMostUsedWords({
    required LanguageEnum learning,
    LanguageEnum knows = LanguageEnum.english,
    int? numberOfWords,
  });

  Future<String> translateText(
    TranslateLanguage sourceLanguage,
    TranslateLanguage targetLanguage,
    String word,
  );
}
