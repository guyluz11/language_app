import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';

part 'package:word_link/infrastructure/tts_repository.dart';

abstract class TtsController {
  static TtsController? _instance;

  static TtsController get instance => _instance ??= _TtsRepository();

  Future<void> _initialize();

  Future<void> speak(String text);
}
