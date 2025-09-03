part of 'package:word_link/domain/controllers/speech_to_text_controller.dart';

class _SpeechToTextRepository extends SpeechToTextController {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;
  bool _isListening = false;
  String _lastWords = '';

  @override
  Future<void> initialize() async {
    if (await Permission.microphone.request().isGranted) {
      _isInitialized = await _speechToText.initialize(
        onError: (error) => print('Error: $error'),
        onStatus: (status) => print('Status: $status'),
      );
    }
  }

  @override
  Future<void> startListening() async {
    if (!_isInitialized) await initialize();
    if (_isInitialized && !_isListening) {
      _isListening = true;
      notifyListeners();
      await _speechToText.listen(
        onResult: (result) {
          _lastWords = result.recognizedWords;
          notifyListeners();
        },
      );
    }
  }

  @override
  Future<void> stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      _isListening = false;
      notifyListeners();
    }
  }

  @override
  String get lastWords => _lastWords;

  @override
  bool get isListening => _isListening;
}