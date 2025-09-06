part of 'package:word_link/domain/controllers/tts_controller.dart';

class _TtsRepository extends TtsController {
  late FlutterTts _flutterTts;
  bool _isSupported = false;
  bool _isSpeaking = false;
  String? _currentLocale;

  @override
  Future<void> initialize() async {
    _isSupported = !Platform.isLinux;

    if (!_isSupported) {
      return;
    }

    _flutterTts = FlutterTts();

    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });
  }

  @override
  Future<void> speak(String text, {LanguageEnum language = LanguageEnum.polish}) async {
    if (!_isSupported) {
      return;
    }
    if (_currentLocale != language.locale) {
      _currentLocale = language.locale;
      await _flutterTts.setLanguage(_currentLocale!);
    }

    _isSpeaking = true;
    notifyListeners();
    await _flutterTts.speak(text);
  }

  @override
  Future<void> stop() async {
    if (!_isSupported) {
      return;
    }
    await _flutterTts.stop();
    _isSpeaking = false;
    notifyListeners();
  }

  @override
  bool get isSpeaking => _isSpeaking;
}
