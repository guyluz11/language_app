part of 'package:word_link/domain/controllers/tts_controller.dart';

class _TtsRepository extends TtsController {
  @override
  Future<void> init() async {
    _supported = kIsWeb ||
        Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isMacOS ||
        Platform.isWindows;

    if (!_supported) {
      return;
    }

    _flutterTts = FlutterTts()
      ..setLanguage('en-US')
      ..setSpeechRate(0.5)
      ..setVolume(1.0)
      ..setPitch(1.0);

    _flutterTts!.setErrorHandler((msg) {
      _logger.e('TTS Error $msg');
    });
  }

  @override
  Future<void> speak(String text) async {
    if (!_supported) {
      return;
    }
    _flutterTts!.speak(text);
  }
}
