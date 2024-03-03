import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OnSignalService {
  static Future<String?> getDeviceNotificationToken() async {
    String? osUserID;
    int count = 0;
    while (osUserID == null) {
      count++;
      await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
      final status = await OneSignal.shared.getDeviceState();
      osUserID = status?.userId;
      await Future.delayed(const Duration(milliseconds: 200));
      if (count == 5) {
        break;
      }
    }
     return osUserID;
  }
}
