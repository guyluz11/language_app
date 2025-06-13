part of 'package:word_link/domain/controllers/language_controller.dart';

/// Repository class that handles language-related operations
class _LanguageRepository extends LanguageController {
  final _downloadedModels = <String>{};
  final _modelManager = OnDeviceTranslatorModelManager();

  @override
  Future<CollectionObject> getMostUsedWords({
    required LanguageEnum learning,
    LanguageEnum knows = LanguageEnum.english,
    int? numberOfWords,
  }) {
    List<WordObject> words = getSourceLanguageWords(learning);

    if (numberOfWords != null) {
      final int length =
          numberOfWords <= words.length ? numberOfWords : words.length;
      words = words.sublist(0, length);
    }
    return createCollectionFromWords(learning, knows, words);
  }

  /// Returns a list of words for the given language
  List<WordObject> getSourceLanguageWords(LanguageEnum language) {
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
    List<WordObject> words,
  ) async {
    final CollectionObject cardsCollection = CollectionObject(
        name: learning.displayName, knows: knows, learning: learning);

    await ensureModelDownloaded(knows.translateLang);

    for (final word in words) {
      cardsCollection.cards.add(CardObject(
        name: word.translation,
        answer: word.word,
        secondaryName: word.hint,
        uri: word.url,
      ));
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
final List<WordObject> polishWords = [
  WordObject(
    word: 'dom',
    hint: 'dome',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2020/03/14/13/25/house-4930613_1280.jpg'),
    translation: 'house',
  ),
  WordObject(
    word: 'stół',
    hint: 'stool',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2021/12/27/09/44/furniture-6896726_1280.jpg'),
    translation: 'table',
  ),
  WordObject(
    word: 'krzesło',
    hint: 'cruise-show',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2017/05/17/04/55/chair-2319866_1280.png'),
    translation: 'chair',
  ),
  WordObject(
    word: 'łóżko',
    hint: 'lose-co',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2020/11/24/11/36/bedroom-5772286_1280.jpg'),
    translation: 'bed',
  ),
  WordObject(
    word: 'okno',
    hint: 'oak-no',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2016/10/05/15/33/window-1716930_1280.jpg'),
    translation: 'window',
  ),
  WordObject(
    word: 'drzwi',
    hint: 'drizzly',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2020/02/01/12/47/door-4810233_1280.jpg'),
    translation: 'door',
  ),
  WordObject(
    word: 'lampa',
    hint: 'lamp a',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2017/10/30/23/34/lamp-2903830_1280.jpg'),
    translation: 'lamp',
  ),
  WordObject(
    word: 'książka',
    hint: 'shawn-ska',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2018/01/17/18/43/book-3088775_1280.jpg'),
    translation: 'book',
  ),
  WordObject(
    word: 'telefon',
    hint: 'telephone',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2019/11/23/11/33/mobile-phone-4646854_1280.jpg'),
    translation: 'phone',
  ),
  WordObject(
    word: 'komputer',
    hint: 'computer',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2020/10/21/18/07/laptop-5673901_1280.jpg'),
    translation: 'computer',
  ),
  WordObject(
    word: 'but',
    hint: 'boot',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2015/03/20/19/07/shoe-682712_1280.jpg'),
    translation: 'shoe',
  ),
  WordObject(
    word: 'spódnica',
    hint: 'spod-knee-tsa',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2015/05/20/11/14/skirt-775217_1280.jpg'),
    translation: 'skirt',
  ),
  WordObject(
    word: 'koszula',
    hint: 'cushula',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2025/05/20/10/57/t-shirt-9611374_1280.jpg'),
    translation: 'shirt',
  ),
  WordObject(
    word: 'sukienka',
    hint: 'sue-keen-ka',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2020/08/26/15/44/wedding-dress-5519820_1280.jpg'),
    translation: 'dress',
  ),
  WordObject(
    word: 'fotel',
    hint: 'photo-tell',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2015/03/01/17/10/armchair-655014_1280.jpg'),
    translation: 'armchair',
  ),
  WordObject(
    word: 'kubek',
    hint: 'cubby-k',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2016/11/29/12/46/coffee-1869599_1280.jpg'),
    translation: 'mug',
  ),
  WordObject(
    word: 'butelka',
    hint: 'butter-lka',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2022/04/07/14/31/bottle-7117637_1280.jpg'),
    translation: 'bottle',
  ),
  WordObject(
    word: 'łyżka',
    hint: 'lizard-ka',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2014/12/02/14/49/soup-spoon-554063_1280.jpg'),
    translation: 'spoon',
  ),
  WordObject(
    word: 'widelec',
    hint: 'weed-lec',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2014/12/02/14/49/cake-fork-554066_1280.jpg'),
    translation: 'fork',
  ),
  WordObject(
    word: 'nożyczki',
    hint: 'no-zhich-key',
    url: Uri.tryParse(
        'https://cdn.pixabay.com/photo/2013/04/22/01/16/scissor-106376_1280.jpg'),
    translation: 'scissors',
  ),
];
