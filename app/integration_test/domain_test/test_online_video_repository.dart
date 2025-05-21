import 'package:map_tube/domain/controllers/controllers.dart';
import 'package:map_tube/domain/objects/audio_object.dart';

class TestOnlineVideoRepository extends OnlineVideoController {
  TestOnlineVideoRepository() {
    OnlineVideoController.instance = this;
  }

  @override
  void dispose() {}

  @override
  Future<AudioObject> downloadAudio(
    AudioObject audioObject, {
    void Function(double p1)? onProgress,
  }) async =>
      _testAudioObject();

  @override
  Future<AudioObject> getMetadata(Uri url) async => _testAudioObject();

  @override
  Future<String?> getSubtitles(String url) async => null;

  AudioObject _testAudioObject() => AudioObject(
        duration: const Duration(minutes: 1),
        title: 'Does Marques Brownlee Prefer Android or Apple?',
        url: Uri.parse('https://youtube.com/shorts/zfHTRMnqY5I'),
        thumbnail: Uri.parse(
          'https://img.youtube.com/vi/zfHTRMnqY5I/sddefault.jpg',
        ),
        savedLocation: '',
      );
}
