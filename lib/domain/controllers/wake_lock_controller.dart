import 'package:wakelock_plus/wakelock_plus.dart';

part 'package:flutter_app_template_atoms/infrastructure/wake_lock_repository.dart';

abstract class WakeLockController {
  static WakeLockController? _instance;

  static WakeLockController get instance => _instance ??= _WakeLockRepository();

  Future<bool> getWakeLock();

  Future setWakeLock(bool state);
}
