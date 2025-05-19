part of 'package:word_link/domain/controllers/tts_controller.dart';

class _TtsRepository extends TtsController {
  late FlutterTts? _flutterTts;
  final _logger = Logger();
  late bool supported;

  @override
  Future<void> init() async {
    supported = kIsWeb ||
        Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isMacOS ||
        Platform.isWindows;

    if (!supported) {
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
    if (!supported) {
      return;
    }
    _flutterTts!.speak(text);
  }
}
