import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:universal_io/io.dart';

part 'package:site/infrastructure/permissions_repository.dart';

abstract class PermissionsController {
  static PermissionsController? _instance;

  static PermissionsController get instance =>
      _instance ??= _PermissionsRepository();

  Future generalNotificationPermission();

  Future preciseAlarmPermission();
}
