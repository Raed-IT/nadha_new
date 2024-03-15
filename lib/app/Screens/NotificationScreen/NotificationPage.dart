import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:delevary/app/Screens/NotificationScreen/NotificationScreenBinding.dart';
import 'package:get/get.dart';

class NotificationPage extends GetPage {
  NotificationPage()
      : super(
          name: AppRoutes.notifications,
          page: () => NotificationScreen(),
          binding: NotificationScreenBinding(),
        );
}
