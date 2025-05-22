import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'package:word_link/domain/objects/cards_related/collection_object.dart';

part 'package:word_link/infrastructure/language_repository.dart';

abstract class LanguageController {
  static LanguageController? _instance;

  static LanguageController get instance => _instance ??= _LanguageRepository();

  Future<CollectionObject> getMostUsedWords(
      {required LanguageEnum sourceLanguage, int numberOfWords = 5});

  List<String> getSourceLanguageWords(LanguageEnum language);

  Future<CollectionObject> createCollectionFromWords(
      LanguageEnum sourceLanguage, List<String> words);

  Future<String> translateText(TranslateLanguage sourceLanguage,
      TranslateLanguage targetLanguage, String word);
}

enum LanguageEnum {
  polish('Polish');

  const LanguageEnum(this.displayName);
  final String displayName;
}

extension LanguageEnumExtension on LanguageEnum {
  TranslateLanguage get translateLang {
    switch (this) {
      case LanguageEnum.polish:
        return TranslateLanguage.polish;
    }
  }
}
