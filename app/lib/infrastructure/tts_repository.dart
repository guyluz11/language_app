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
  Future<void> speak(String text, {required String language}) async {
    if (!_isSupported) {
      return;
    }
    await _flutterTts.setLanguage(language);
    await _flutterTts.speak(text);
  }

  @override
  Future<List<String>> getLanguages() async {
    if (!_isSupported) {
      return [];
    }
    try {
      final List languagesTemp = (await _flutterTts.getLanguages) as List;

      return List<String>.from(languagesTemp);
    } catch (e) {
      logger.e('Error getting languages $e');
    }

    return [];
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
