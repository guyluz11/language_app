part of 'package:word_link/domain/controllers/tts_controller.dart';

class _TtsRepository extends TtsController {
  final FlutterTts _flutterTts = FlutterTts();
  TtsState _ttsState = TtsState.stopped;

  @override
  TtsState get state => _ttsState;

  FlutterTts get tts => _flutterTts;

  @override
  Future<void> initialize() async {
    _flutterTts
      ..setLanguage('en-US')
      ..setSpeechRate(0.5)
      ..setVolume(1.0)
      ..setPitch(1.0);

    _flutterTts.setErrorHandler((msg) {
      print('TTS Error: $msg');
    });
  }

  @override
  Future<void> speak(String text) async {
    if (_ttsState == TtsState.playing) {
      await stop();
    }
    await _flutterTts.speak(text);
  }

  @override
  Future<void> stop() async => await _flutterTts.stop();

  @override
  Future<void> pause() async => await _flutterTts.pause();

  @override
  Future<void> setLanguage(String language) async =>
      await _flutterTts.setLanguage(language);

  @override
  Future<void> setSpeechRate(double rate) async =>
      await _flutterTts.setSpeechRate(rate);

  @override
  Future<void> setVolume(double volume) async =>
      await _flutterTts.setVolume(volume);

  @override
  Future<void> setPitch(double pitch) async =>
      await _flutterTts.setPitch(pitch);

  @override
  Future<void> setVoice(Map<String, String> voice) async =>
      await _flutterTts.setVoice(voice);

  @override
  Future<List<dynamic>> getLanguages() async =>
      (await _flutterTts.getLanguages) as List<dynamic>;

  @override
  Future<List<Map>> getVoices() async => await _flutterTts.getVoices;

  @override
  Future<void> dispose() async => await _flutterTts.stop();
}
