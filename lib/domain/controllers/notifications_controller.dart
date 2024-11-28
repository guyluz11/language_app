import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/presentation/core/theme_data.dart';

part 'package:word_link/infrastructure/notifications_repository.dart';

abstract class NotificationsController {
  static NotificationsController? _instance;

  static NotificationsController get instance =>
      _instance ??= _NotificationsRepository();

  void init();

  Future send({
    required DateTime date,
    required String title,
    required NotificationVariant variant,
    String? body,
  });

  Future<bool> isPermissionGranted();

  Future generalPermission() =>
      PermissionsController.instance.generalNotificationPermission();

  Future preciseAlarmPermission() =>
      PermissionsController.instance.preciseAlarmPermission();

  Future cancelAllNotifications();
}
