part of 'package:word_link/domain/controllers/tts_controller.dart';

class _TtsRepository extends TtsController {
  final FlutterTts _flutterTts = FlutterTts();
  TtsState _ttsState = TtsState.stopped;
  Function(TtsState)? _onStateChange;
  bool _isInitialized = false;

  @override
  TtsState get state => _ttsState;

  FlutterTts get tts => _flutterTts;

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _flutterTts.setCompletionHandler(() {
      _updateState(TtsState.stopped);
    });

    _flutterTts.setErrorHandler((msg) {
      print('TTS Error: $msg');
      _updateState(TtsState.stopped);
    });

    _isInitialized = true;
  }

  @override
  void onStateChange(Function(TtsState) callback) {
    _onStateChange = callback;
  }

  void _updateState(TtsState state) {
    _ttsState = state;
    _onStateChange?.call(_ttsState);
  }

  @override
  Future<void> speak(String text) async {
    if (!_isInitialized) await initialize();

    if (_ttsState == TtsState.playing) {
      await stop();
    }

    final result = await _flutterTts.speak(text);
    if (result == 1) {
      _updateState(TtsState.playing);
    }
  }

  @override
  Future<void> stop() async {
    final result = await _flutterTts.stop();
    if (result == 1) {
      _updateState(TtsState.stopped);
    }
  }

  @override
  Future<void> pause() async {
    final result = await _flutterTts.pause();
    if (result == 1) {
      _updateState(TtsState.paused);
    }
  }

  @override
  Future<void> setLanguage(String language) async {
    await _flutterTts.setLanguage(language);
  }

  @override
  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  @override
  Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }

  @override
  Future<void> setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }

  @override
  Future<void> setVoice(Map<String, String> voice) async {
    await _flutterTts.setVoice(voice);
  }

  @override
  Future<dynamic> getLanguages() async {
    return await _flutterTts.getLanguages;
  }

  @override
  Future<dynamic> getVoices() async {
    return await _flutterTts.getVoices;
  }

  @override
  void dispose() {
    _flutterTts.stop();
  }
}
