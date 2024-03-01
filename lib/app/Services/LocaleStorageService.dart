import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/Data/StorageController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LocaleStorageService {
  static void setUserData({required UserModel user, required String token}) {
    Get.find<MainController>().token.value = token;
    Get.find<MainController>().user.value = user;
    StorageController.setData(key: "token", value: token);
    Logger().w(token);
  }

  static Future<void> getUserData() async {
    String? token = await StorageController.getData(key: "token");
    Logger().w(token);
    Get.find<MainController>().token.value = token;
  }

  static Future<void> logOut() async {
    StorageController.removeKey(key: "token");
    Get.find<MainController>().token.value = null;
    Get.find<MainController>().user.value = null;
    Get.offAllNamed(AppRoutes.mainAuthScreen);
  }
}
