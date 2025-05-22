part of 'package:word_link/domain/controllers/language_controller.dart';

class _LanguageRepository extends LanguageController {
  @override
  Future<CollectionObject> getMostUsedWords({
    required LanguageEnum language,
    int numberOfWords = 5,
  }) async {
    final List<String> words = _getSourceLanguageWords(language);

    final Map<String, String> wordPairs = await _getTranslatedWords(
        language.translateLang, words.sublist(0, numberOfWords));

    final cards = wordPairs.entries
        .take(numberOfWords)
        .map((entry) => CardObject(name: entry.key, answer: entry.value))
        .toList();

    return CollectionObject(
      name: LanguageEnum.polish.displayName,
      cardsTemp: cards,
    );
  }

  List<String> _getSourceLanguageWords(LanguageEnum language) {
    switch (language) {
      case LanguageEnum.polish:
        return polishWords;
    }
  }
}

enum LanguageEnum {
  polish('Polish', TranslateLanguage.polish),
  ;

  const LanguageEnum(this.displayName, this.translateLang);
  final String displayName;
  final TranslateLanguage translateLang;
}

Future<Map<String, String>> _getTranslatedWords(
    TranslateLanguage language, List<String> words) async {
  final Map<String, String> translatedWords = {};

  for (final word in words) {
    final translatedWord = await _translateText(
        TranslateLanguage.polish, TranslateLanguage.english, word);
    translatedWords[word] = translatedWord;
  }

  return translatedWords;
}

Future<String> _translateText(TranslateLanguage sourceLanguage,
    TranslateLanguage targetLanguage, String word) async {
  final translator = OnDeviceTranslator(
      sourceLanguage: sourceLanguage, targetLanguage: targetLanguage);

  final modelManager = OnDeviceTranslatorModelManager();
  final bool isModelDownloaded =
      await modelManager.isModelDownloaded(targetLanguage.bcpCode);

  if (!isModelDownloaded) {
    await modelManager.downloadModel(targetLanguage.bcpCode);
  }

  final String result = await translator.translateText(word);

  translator.close();

  return result;
}

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
