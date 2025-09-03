import 'package:flutter_soloud/flutter_soloud.dart';

part 'package:word_link/infrastructure/player_repository.dart';

abstract class PlayerController {
  static PlayerController? _instance;

  static PlayerController get instance => _instance ??= _PlayerRepository();

  Future<void> init();

  Future<void> dispose();

  void setIsSound({required bool value});

  bool isSound();

  Future play(SoundType type, {double volume = 1});
}

enum SoundType {
  click1('ui_click1.ogg'),
  click2('ui_click2.ogg'),
  click3('ui_click3.ogg'),
  startSession('start_session.wav'),
  sessionCompleted('session_completed.wav'),
  checkBoxChecked('writing_on_a_book_with_a_pen_signing_v.wav'),
  ;

  const SoundType(this.fileName);

  final String fileName;
}
