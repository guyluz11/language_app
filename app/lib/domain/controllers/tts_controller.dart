import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:word_link/infrastructure/core/logger.dart';

part 'package:word_link/infrastructure/tts_repository.dart';

abstract class TtsController extends ChangeNotifier {
  static TtsController? _instance;

  static TtsController get instance => _instance ??= _TtsRepository();

  Future<void> initialize();

  Future<void> speak(String text, {required String language});

  Future<List<String>> getLanguages();

  Future<void> stop();

  bool get isSpeaking;
}
