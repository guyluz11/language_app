import 'package:google_mlkit_translation/google_mlkit_translation.dart';

enum LanguageEnum {
  polish(
    'Polish',
    'https://flagcdn.com/w2560/pl.png',
    'https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExZWNjOGFtamZlNjJ2ejFpeWJuYXQxYWVuZXQ1ZDIwcWszZ2dzOHVjeCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/hMoTYxdrlkn1bBmAzQ/giphy.gif',
    'pl-PL',
    TranslateLanguage.polish,
  ),
  english(
    'English',
    'https://flagcdn.com/w2560/gb.png',
    'https://media.giphy.com/media/3o7TKz2eMXx7dn95FS/giphy.gif',
    'en-US',
    TranslateLanguage.english,
  ),
  german(
    'German',
    'https://flagcdn.com/w2560/de.png',
    '',
    'de-DE',
    TranslateLanguage.german,
  ),
  french(
    'French',
    'https://flagcdn.com/w2560/fr.png',
    '',
    'fr-FR',
    TranslateLanguage.french,
  ),
  spanish(
    'Spanish',
    'https://flagcdn.com/w2560/es.png',
    '',
    'es-ES',
    TranslateLanguage.spanish,
  ),
  italian(
    'Italian',
    'https://flagcdn.com/w2560/it.png',
    '',
    'it-IT',
    TranslateLanguage.italian,
  ),
  hebrew(
    'Hebrew',
    'https://flagcdn.com/w2560/il.png',
    '',
    'he-IL',
    TranslateLanguage.hebrew,
  ),
  chinese(
    'Chinese',
    'https://flagcdn.com/w2560/cn.png',
    '',
    'zh-CN',
    TranslateLanguage.chinese,
  ),
  hindi(
    'Hindi',
    'https://flagcdn.com/w2560/in.png',
    '',
    'hi-IN',
    TranslateLanguage.hindi,
  ),
  portuguese(
    'Portuguese',
    'https://flagcdn.com/w2560/br.png',
    '',
    'pt-BR',
    TranslateLanguage.portuguese,
  ),
  russian(
    'Russian',
    'https://flagcdn.com/w2560/ru.png',
    '',
    'ru-RU',
    TranslateLanguage.russian,
  ),
  japanese(
    'Japanese',
    'https://flagcdn.com/w2560/jp.png',
    '',
    'ja-JP',
    TranslateLanguage.japanese,
  );

  const LanguageEnum(
    this.displayName,
    this.flagUrl,
    this.gifUrl,
    this.locale,
    this.translateLanguage,
  );
  final String displayName;
  final String flagUrl;
  final String gifUrl;
  final String locale;
  final TranslateLanguage translateLanguage;

  static LanguageEnum fromString(String displayName) {
    for (final LanguageEnum l in LanguageEnum.values) {
      if (displayName == l.name) {
        return l;
      }
    }
    return LanguageEnum.english;
  }
}
