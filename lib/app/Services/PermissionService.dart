import 'package:flutter_animate/flutter_animate.dart';
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

  static Future postStoragePermission() async {
    PermissionStatus statusS = await Permission.storage.status;
    if (statusS == PermissionStatus.granted) {
      return;
    } else {
      await Permission.storage.request();
      await postStoragePermission();
    }
  }
  static Future postInstallPackagesPermission() async {
    PermissionStatus status = await Permission.requestInstallPackages.status;
    if (status == PermissionStatus.granted) {
      return;
    } else {
      await Permission.requestInstallPackages.request();
      await postInstallPackagesPermission();
    }
  }
}
