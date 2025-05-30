part of 'package:site/domain/controllers/wake_lock_controller.dart';

class _WakeLockRepository extends WakeLockController {
  @override
  Future<bool> getWakeLock() => WakelockPlus.enabled;

  @override
  Future setWakeLock({required bool state}) async {
    if (state) {
      WakelockPlus.enable();
      return;
    }
    WakelockPlus.disable();
  }
}
