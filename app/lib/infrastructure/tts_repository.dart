part of 'package:word_link/domain/controllers/tts_controller.dart';

class _TtsRepository extends TtsController {
  late FlutterTts _flutterTts;
  late bool _supported;
  String? currentLocal;

  @override
  Future<void> init() async {
    _supported = !Platform.isLinux;

    if (!_supported) {
      return;
    }

    _flutterTts = FlutterTts();
  }

  @override
  Future<void> speak(String text, LanguageEnum language) async {
    if (!_supported) {
      return;
    }
    if (currentLocal != language.locale) {
      currentLocal = language.locale;
      await _flutterTts.setLanguage(currentLocal!);
    }

    await _flutterTts.speak(text);
  }
}
