part of 'package:word_link/domain/controllers/language_controller.dart';

/// Repository class that handles language-related operations
class _LanguageRepository extends LanguageController {
  final _downloadedModels = <String>{};
  final _modelManager = OnDeviceTranslatorModelManager();

  @override
  Future<CollectionObject> getMostUsedWords({
    required LanguageEnum learning,
    LanguageEnum knows = LanguageEnum.english,
    int numberOfWords = 10,
  }) {
    final List<String> words = getSourceLanguageWords(learning);

    return createCollectionFromWords(
      learning,
      knows,
      words.sublist(0, numberOfWords),
    );
  }

  /// Returns a list of words for the given language
  List<String> getSourceLanguageWords(LanguageEnum language) {
    switch (language) {
      case LanguageEnum.polish:
        return polishWords;

      case LanguageEnum.english:
        return [];
    }
  }

  /// Creates a collection of cards from the given words
  Future<CollectionObject> createCollectionFromWords(
    LanguageEnum learning,
    LanguageEnum knows,
    List<String> words,
  ) async {
    final CollectionObject cardsCollection = CollectionObject(
        name: learning.displayName, knows: knows, learning: learning);

    await ensureModelDownloaded(knows.translateLang);

    for (final word in words) {
      final translatedWord = await translateText(
        learning.translateLang,
        knows.translateLang,
        word,
      );
      cardsCollection.cards.add(CardObject(name: translatedWord, answer: word));
    }

    return cardsCollection;
  }

  /// Translates a word from source language to target language
  Future<String> translateText(
    TranslateLanguage sourceLanguage,
    TranslateLanguage targetLanguage,
    String word,
  ) async {
    try {
      final translator = OnDeviceTranslator(
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      );

      final String result = await translator.translateText(word);
      translator.close();
      return result;
    } catch (e) {
      logger.e('Translation error: $e');
      // Return the original word if translation fails
      return word;
    }
  }

  /// Ensures that the translation model for the target language is downloaded
  Future<void> ensureModelDownloaded(TranslateLanguage targetLanguage) async {
    final code = targetLanguage.bcpCode;

    if (_downloadedModels.contains(code)) return;

    try {
      final isDownloaded = await _modelManager.isModelDownloaded(code);
      if (!isDownloaded) {
        await _modelManager.downloadModel(code);
      }
      _downloadedModels.add(code);
    } catch (e) {
      logger.e('Error downloading model: $e');
      // If model download fails, we'll try to use the model anyway
      // as it might be partially downloaded or available in a different way
      _downloadedModels.add(code);
    }
  }
}

/// Extension to convert LanguageEnum to TranslateLanguage
extension LanguageEnumExtension on LanguageEnum {
  /// Returns the corresponding TranslateLanguage for this LanguageEnum
  TranslateLanguage get translateLang {
    switch (this) {
      case LanguageEnum.polish:
        return TranslateLanguage.polish;

      case LanguageEnum.english:
        return TranslateLanguage.english;
    }
  }
}

/// List of common Polish words
const List<String> polishWords = [
  'i',
  'w',
  'nie',
  'to',
  'że',
  'na',
  'się',
  'z',
  'jest',
  'do',
  'co',
  'jak',
  'a',
  'o',
  'tak',
  'ale',
  'po',
  'go',
  'mi',
  'czy',
  'ty',
  'mnie',
  'dla',
  'już',
  'za',
  'bo',
  'by',
  'był',
  'być',
  'ma',
  'tego',
  'jej',
  'przy',
  'ich',
  'albo',
  'ze',
  'mu',
  'tym',
  'nas',
  'też',
  'ten',
  'od',
  'kiedy',
  'tam',
  'czyli',
  'więc',
  'jeśli',
  'dlatego',
  'te',
  'wszystko',
  'nasz',
  'tu',
  'trzeba',
  'jako',
  'bardziej',
  'nic',
  'który',
  'było',
  'czas',
  'gdy',
  'jeszcze',
  'potem',
  'teraz',
  'ciebie',
  'dobrze',
  'raz',
  'może',
  'nigdy',
  'nawet',
  'wszyscy',
  'lecz',
  'zawsze',
  'czemu',
  'sam',
  'twoje',
  'czasu',
  'była',
  'bardzo',
  'sobie',
  'są',
  'taki',
  'tylko',
  'nami',
  'chce',
  'więcej',
  'nasze',
  'kto',
  'mogę',
  'mógł',
  'będzie',
  'gdzie',
  'potrzebuje',
  'czego',
  'muszę',
  'mój',
  'twoja',
  'bym',
  'kim',
  'znowu',
];
