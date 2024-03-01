import 'package:get_storage/get_storage.dart';

import '../route/Routs.dart';

class StorageController {
  static dynamic getData({required String key}) async {
    return await GetStorage(AppRoutes.appName).read(key);
  }

  static Future<void> setData(
      {required String key, required dynamic value}) async {
    await GetStorage(AppRoutes.appName).write(key, value);
  }

  static Future<void> removeKey({
    required String key,
  }) async {
    await GetStorage(AppRoutes.appName).remove(
      key,
    );
  }

  static bool hasData({required String key}) {
    return GetStorage(AppRoutes.appName).hasData(key);
  }
}
