import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:word_link/infrastructure/core/logger.dart';

part 'package:word_link/infrastructure/speech_to_text_repository.dart';

abstract class SpeechToTextController extends ChangeNotifier {
  static SpeechToTextController? _instance;

  static SpeechToTextController get instance =>
      _instance ??= _SpeechToTextRepository();

  Future<void> initialize();

  Future<void> startListening({required String localeId});

  String get lastWords;

  bool get isListening;

  Future<List<dynamic>> getLocales();

  bool get isDone;

  String get status;
}
