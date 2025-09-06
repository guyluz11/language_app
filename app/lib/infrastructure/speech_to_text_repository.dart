part of 'package:word_link/domain/controllers/speech_to_text_controller.dart';

class _SpeechToTextRepository extends SpeechToTextController {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;
  bool _isListening = false;
  String _lastWords = '';
  String _status = '';
  bool _isDone = false;

  @override
  Future<void> initialize() async {
    if (await Permission.microphone.request().isGranted) {
      _isInitialized = await _speechToText.initialize(
        onError: (error) {
          logger.i('Error: $error');
          _status = 'error';
          notifyListeners();
        },
        onStatus: (status) {
          logger.i('Status: $status');
          _status = status;
          if (status == 'done' || status == 'notListening') {
            _isDone = true;
            _isListening = false;
          }
          notifyListeners();
        },
      );
    }
  }

  @override
  Future<void> startListening() async {
    if (!_isInitialized) await initialize();
    if (_isInitialized && !_isListening) {
      _isListening = true;
      _isDone = false;
      _lastWords = '';
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
      _isDone = true;
      notifyListeners();
    }
  }

  @override
  String get lastWords => _lastWords;

  @override
  bool get isListening => _isListening;

  @override
  String get status => _status;

  @override
  bool get isDone => _isDone;
}
