import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'package:word_link/domain/objects/cards_related/collection_object.dart';
import 'package:word_link/infrastructure/core/logger.dart';

part 'package:word_link/infrastructure/language_repository.dart';

abstract class LanguageController {
  static LanguageController? _instance;

  static LanguageController get instance => _instance ??= _LanguageRepository();

  Future<CollectionObject> getMostUsedWords({
    required LanguageEnum sourceLanguage,
    LanguageEnum targetLanguage = LanguageEnum.english,
    int numberOfWords = 10,
  });
}

enum LanguageEnum {
  polish(
    'Polish',
    'https://flagcdn.com/w2560/pl.png',
    'https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExZWNjOGFtamZlNjJ2ejFpeWJuYXQxYWVuZXQ1ZDIwcWszZ2dzOHVjeCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/hMoTYxdrlkn1bBmAzQ/giphy.gif',
  ),
  english(
    'English',
    'https://flagcdn.com/w2560/gb.png',
    'https://media.giphy.com/media/3o7TKz2eMXx7dn95FS/giphy.gif',
  );

  const LanguageEnum(this.displayName, this.flagUrl, this.gifUrl);
  final String displayName;
  final String flagUrl;
  final String gifUrl;
}
