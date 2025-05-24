part of 'package:word_link/domain/controllers/language_controller.dart';

class _LanguageRepository extends LanguageController {
  @override
  Future<CollectionObject> getMostUsedWords({
    required LanguageEnum sourceLanguage,
    LanguageEnum targetLanguage = LanguageEnum.english,
    int numberOfWords = 5,
  }) async {
    final List<String> words = getSourceLanguageWords(sourceLanguage);

    final cardCollection = await createCollectionFromWords(
        sourceLanguage, targetLanguage, words.sublist(0, numberOfWords));

    return cardCollection;
  }

  List<String> getSourceLanguageWords(LanguageEnum language) {
    switch (language) {
      case LanguageEnum.polish:
        return polishWords;

      case LanguageEnum.english:
        return [];
    }
  }

  Future<CollectionObject> createCollectionFromWords(
      LanguageEnum sourceLanguage,
      LanguageEnum targetLanguage,
      List<String> words) async {
    final CollectionObject cardsCollection =
        CollectionObject(name: sourceLanguage.displayName);

    for (final word in words) {
      final translatedWord = await translateText(
          sourceLanguage.translateLang, targetLanguage.translateLang, word);
      cardsCollection.cards.add(CardObject(name: word, answer: translatedWord));
    }

    return cardsCollection;
  }

  Future<String> translateText(TranslateLanguage sourceLanguage,
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
}

extension LanguageEnumExtension on LanguageEnum {
  TranslateLanguage get translateLang {
    switch (this) {
      case LanguageEnum.polish:
        return TranslateLanguage.polish;

      case LanguageEnum.english:
        return TranslateLanguage.english;
    }
  }
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
