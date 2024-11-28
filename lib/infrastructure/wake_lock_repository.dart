part of 'package:flutter_app_template_atoms/domain/controllers/wake_lock_controller.dart';

class _WakeLockRepository extends WakeLockController {
  @override
  Future<bool> getWakeLock() => WakelockPlus.enabled;

  @override
  Future setWakeLock(bool state) async {
    if (state) {
      WakelockPlus.enable();
      return;
    }
    WakelockPlus.disable();
  }
}
