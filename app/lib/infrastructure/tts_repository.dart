part of 'package:word_link/domain/controllers/tts_controller.dart';

class _TtsRepository extends TtsController {
  late FlutterTts _flutterTts;
  late bool _supported;

  @override
  Future<void> init() async {
    _supported = !Platform.isLinux;

    if (!_supported) {
      return;
    }

    _flutterTts = FlutterTts();
  }

  @override
  Future<void> speak(String text) async {
    if (!_supported) {
      return;
    }
    await _flutterTts.speak(text);
  }
}
