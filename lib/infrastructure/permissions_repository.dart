part of 'package:flutter_app_template_atoms/domain/controllers/permissions_controller.dart';

class _PermissionsRepository extends PermissionsController {
  @override
  Future generalNotificationPermission() =>
      AwesomeNotifications().requestPermissionToSendNotifications();

  @override
  Future preciseAlarmPermission() async {
    // TODO: Fix when we ca check the permission. issue:
    // https://discord.com/channels/888523488376279050/1254751072682119208
    // final List<NotificationPermission> permissions =
    //     await AwesomeNotifications().checkPermissionList();
    if (await isAndroid12OrAbove()) {
      AwesomeNotifications().showAlarmPage();
    }
  }

  Future<bool> isAndroid12OrAbove() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      // Android 12 is API level 31
      return sdkInt >= 31;
    }
    return false;
  }
}
