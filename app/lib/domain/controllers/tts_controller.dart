import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';

part 'package:word_link/infrastructure/tts_repository.dart';

abstract class TtsController {
  static TtsController? _instance;

  static TtsController get instance => _instance ??= _TtsRepository();

  Future<void> init();

  Future<void> speak(String text);
}
