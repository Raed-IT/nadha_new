import 'package:get/get.dart';
import 'package:nadha/app/pages/notifications_screen/notifications_binding.dart';
import 'package:nadha/app/pages/notifications_screen/notifications_screen.dart';
import 'package:nadha/app/route/routs.dart';

class NotificationsPage extends GetPage {
  NotificationsPage()
      : super(
          name: AppRoutes.NOTIFICATIONS,
          page: () => NotificationsScreen(),
          binding: NotificationsScreenBinding(),
        );
}
