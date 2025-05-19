part of 'package:word_link/domain/controllers/tts_controller.dart';

class _TtsRepository extends TtsController {
  late FlutterTts? _flutterTts;
  final _logger = Logger();
  bool _isInitialized = false;

  @override
  Future<void> _initialize() async {
    _flutterTts = FlutterTts()
      ..setLanguage('en-US')
      ..setSpeechRate(0.5)
      ..setVolume(1.0)
      ..setPitch(1.0);

    _flutterTts!.setErrorHandler((msg) {
      _logger.e('TTS Error $msg');
    });

    _isInitialized = true;
  }

  @override
  Future<void> speak(String text) async {
    if (!_isInitialized) {
      await _initialize();
    }
    await _flutterTts!.speak(text);
  }
}
