import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';

part 'package:word_link/infrastructure/tts_repository.dart';

abstract class TtsController {
  static TtsController? _instance;

  static TtsController get instance => _instance ??= _TtsRepository();

  late FlutterTts? _flutterTts;
  final _logger = Logger();
  late bool _supported;

  Future<void> init();

  Future<void> speak(String text);
}
