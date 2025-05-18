import 'package:flutter_tts/flutter_tts.dart';

part 'package:word_link/infrastructure/tts_repository.dart';

abstract class TtsController {
  static TtsController? _instance;

  static TtsController get instance => _instance ??= _TtsRepository();

  TtsState get state;

  Future<void> initialize();

  Future<void> speak(String text);

  Future<void> stop();

  Future<void> pause();

  Future<void> setLanguage(String language);

  Future<void> setSpeechRate(double rate);

  Future<void> setVolume(double volume);

  Future<void> setPitch(double pitch);

  Future<void> setVoice(Map<String, String> voice);

  Future<List<dynamic>> getLanguages();

  Future<List<Map>> getVoices();

  Future<void> dispose();
}

enum TtsState { playing, stopped, paused, continued }
