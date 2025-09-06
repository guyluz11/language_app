part of 'package:word_link/domain/controllers/player_controller.dart';

class _PlayerRepository extends PlayerController {
  bool _isSound = true;
  late SoLoud player;
  final Map<SoundType, AudioSource> _preloadedSounds = {};

  @override
  Future<void> init() async {
    player = SoLoud.instance;
    await player.init();
    for (final soundType in SoundType.values) {
      final source =
          await player.loadAsset('assets/sound_effects/${soundType.fileName}');
      _preloadedSounds[soundType] = source;
    }
  }

  @override
  Future<void> dispose() async {
    for (final source in _preloadedSounds.values) {
      await player.disposeSource(source);
    }
    _preloadedSounds.clear();
  }

  @override
  Future play(SoundType type, {double volume = 1}) async {
    if (!_isSound) return;

    final source = _preloadedSounds[type];
    if (source == null) return;

    await player.play(source, volume: volume);
  }

  @override
  void setIsSound({required bool value}) => _isSound = value;

  @override
  bool isSound() => _isSound;
}
