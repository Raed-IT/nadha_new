import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initial() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_flutternotification');

    await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(android: initializationSettingsAndroid));
  }

  static Future<void> showProgressNotification(
      {required int progress,
      required String title,
      // String icon = "ic_stat_assignment_returned",
      required String desc}) async {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("update", "update",
            channelShowBadge: false,
            onlyAlertOnce: true,
            showProgress: true,
            maxProgress: 100,
            playSound: true,
            progress: progress);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      desc,
      NotificationDetails(android: androidNotificationDetails),
    );
  }
}
