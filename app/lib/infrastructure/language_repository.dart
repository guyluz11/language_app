part of 'package:word_link/domain/controllers/language_controller.dart';

class _LanguageRepository extends LanguageController {
  @override
  CollectionObject getMostUsedWords(
      {required LanguageEnum language, int numberOfWords = 5,}) {
    final Map<String, String> wordMap = _getWordMapForLanguage(language);

    final wordPairs = wordMap.entries
        .take(numberOfWords)
        .map((entry) => CardObject(name: entry.key, answer: entry.value))
        .toList();
    return CollectionObject(
        name: LanguageEnum.polish.displayName, cardsTemp: wordPairs,);
  }

  Map<String, String> _getWordMapForLanguage(LanguageEnum language) {
    switch (language) {
      case LanguageEnum.polish:
        return polishWords;
    }
  }
}

enum LanguageEnum {
  polish('Polish'),;


  const LanguageEnum(this.displayName);
  final String displayName;
}

const Map<String, String> polishWords = {
  'i': 'and',
  'w': 'in',
  'nie': 'not',
  'to': 'it',
  'że': 'that',
  'na': 'on',
  'się': 'self',
  'z': 'with',
  'jest': 'is',
  'do': 'to',
  'co': 'what',
  'jak': 'how',
  'a': 'but',
  'o': 'about',
  'tak': 'so',
  'ale': 'but',
  'po': 'after',
  'go': 'him',
  'mi': 'me',
  'czy': 'whether',
  'ty': 'you',
  'mnie': 'me',
  'dla': 'for',
  'już': 'already',
  'za': 'for',
  'bo': 'because',
  'by': 'would',
  'był': 'was',
  'być': 'be',
  'ma': 'has',
  'tego': 'that',
  'jej': 'her',
  'przy': 'near',
  'ich': 'their',
  'albo': 'or',
  'ze': 'with',
  'mu': 'him',
  'tym': 'that',
  'nas': 'us',
  'też': 'also',
  'ten': 'this',
  'od': 'from',
  'kiedy': 'when',
  'tam': 'there',
  'czyli': 'that',
  'więc': 'so',
  'jeśli': 'if',
  'dlatego': 'therefore',
  'te': 'these',
  'wszystko': 'everything',
  'nasz': 'our',
  'tu': 'here',
  'trzeba': 'must',
  'jako': 'as',
  'bardziej': 'more',
  'nic': 'nothing',
  'który': 'which',
  'było': 'was',
  'czas': 'time',
  'gdy': 'when',
  'jeszcze': 'still',
  'potem': 'then',
  'teraz': 'now',
  'ciebie': 'you',
  'dobrze': 'well',
  'raz': 'once',
  'może': 'maybe',
  'nigdy': 'never',
  'nawet': 'even',
  'wszyscy': 'everyone',
  'lecz': 'but',
  'zawsze': 'always',
  'czemu': 'why',
  'sam': 'self',
  'twoje': 'your',
  'czasu': 'time',
  'była': 'was',
  'bardzo': 'very',
  'sobie': 'self',
  'są': 'are',
  'taki': 'such',
  'tylko': 'only',
  'nami': 'us',
  'chce': 'wants',
  'więcej': 'more',
  'nasze': 'our',
  'kto': 'who',
  'mogę': 'can',
  'mógł': 'could',
  'będzie': 'will',
  'gdzie': 'where',
  'potrzebuje': 'needs',
  'czego': 'what',
  'muszę': 'must',
  'mój': 'my',
  'twoja': 'your',
  'bym': 'would',
  'kim': 'who',
  'znowu': 'again',
};
