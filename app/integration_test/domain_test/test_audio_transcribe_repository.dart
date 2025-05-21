import 'package:flutter/src/foundation/consolidate_response.dart';
import 'package:map_tube/domain/controllers/controllers.dart';
import 'package:map_tube/domain/objects/audio_object.dart';

class TestAudioTranscribeRepository extends AudioTranscribeController {
  TestAudioTranscribeRepository() {
    AudioTranscribeController.instance = this;
  }

  @override
  Future<void> init() async {}

  @override
  Future<String> audioFileToText(AudioObject audio) async =>
      'Does Marquez Brownlee like Android or iOS better? Personally, '
      'I have two phones, right? I carry this Android phone in my right '
      'pocket and I carry the iPhone in my left pocket. And my main SIM '
      'card with the phone number that I use the most is in the Android '
      "phone. But I have the iPhone because there's so many things, I have "
      "to be familiar with both worlds, but there's so many things that are "
      'just a little bit better on the iPhone. I have family group chats '
      "and FaceTime's and all that, but there's also camera stuff. There's "
      'some apps that are iPhone only. My phone key is on my iPhone. '
      "So it's, I split my time, like for real, but I do prefer if I could "
      'only use one. I would just have the Android phone.';

  @override
  void dispose() {}

  @override
  Future<void> waitForInitialization({BytesReceivedCallback? callback}) async {}
}
