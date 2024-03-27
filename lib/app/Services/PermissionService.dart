import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future postNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    if (status == PermissionStatus.granted) {
      return;
    } else {
      await Permission.notification.request();
      Future.delayed(20.seconds, () => postNotificationPermission());
    }
  }
}
