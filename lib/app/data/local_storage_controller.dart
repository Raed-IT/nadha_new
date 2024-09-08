import 'package:get_storage/get_storage.dart';
import 'package:nadha/app/route/routs.dart';

class StorageController {
  static dynamic getData({required String key}) async {
    return await GetStorage(AppRoutes.APP_NAME).read(key);
  }

  static Future<void> setData(
      {required String key, required dynamic value}) async {
    await GetStorage(AppRoutes.APP_NAME).write(key, value);
  }

  static Future<void> removeKey({
    required String key,
  }) async {
    await GetStorage(AppRoutes.APP_NAME).remove(
      key,
    );
  }

  static bool hasData({required String key}) {
    return GetStorage(AppRoutes.APP_NAME).hasData(key);
  }
}
