import 'dart:io';

import 'package:flutter_vibrate/flutter_vibrate.dart';

part 'package:flutter_app_template_atoms/infrastructure/vibration_repository.dart';

abstract class VibrationController {
  static VibrationController? _instance;

  static VibrationController get instance =>
      _instance ??= _VibrationRepository();

  late bool supported;

  Future init();

  Future vibrate(VibrationType type);
}

enum VibrationType { light, medium, heavy }
