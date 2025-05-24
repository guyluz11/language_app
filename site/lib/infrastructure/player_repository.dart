part of 'package:site/domain/controllers/player_controller.dart';

class _PlayerRepository extends PlayerController {
  late AudioPlayer player;

  bool _isSound = true;

  @override
  void init() => player = AudioPlayer();

  @override
  Future play(SoundType type) async {
    if (_isSound) {
      player.play(AssetSource('sound_effects/${type.fileName}'));
    }
  }

  @override
  void setIsSound({required bool value}) => _isSound = value;

  @override
  bool isSound() => _isSound;
}
