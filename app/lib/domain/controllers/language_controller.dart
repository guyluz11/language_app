import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'package:word_link/domain/objects/cards_related/collection_object.dart';
import 'package:word_link/domain/objects/cards_related/word_object.dart'
    show WordObject;
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
}

enum LanguageEnum {
  polish(
      'Polish',
      'https://flagcdn.com/w2560/pl.png',
      'https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExZWNjOGFtamZlNjJ2ejFpeWJuYXQxYWVuZXQ1ZDIwcWszZ2dzOHVjeCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/hMoTYxdrlkn1bBmAzQ/giphy.gif',
      'pl-PL'),
  english('English', 'https://flagcdn.com/w2560/gb.png',
      'https://media.giphy.com/media/3o7TKz2eMXx7dn95FS/giphy.gif', 'en-US');

  const LanguageEnum(this.displayName, this.flagUrl, this.gifUrl, this.locale);
  final String displayName;
  final String flagUrl;
  final String gifUrl;
  final String locale;

  static LanguageEnum fromString(String displayName) {
    for (final LanguageEnum l in LanguageEnum.values) {
      if (displayName == l.name) {
        return l;
      }
    }
    return LanguageEnum.english;
  }
}
