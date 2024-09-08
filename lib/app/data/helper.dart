import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/cart_item_model.dart';
import 'package:nadha/app/data/model/user_model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'local_storage_controller.dart';

class Helper {
  static String catStorageKye = "nadhaCart";

  static Future<void> saveUserData(
      {required UserModel user, required String token}) async {
    Get.find<MainController>().user.value = user;
    Get.find<MainController>().token.value = token;
    await StorageController.setData(key: "user", value: user);
    await StorageController.setData(key: "token", value: token);
  }

  static Future<void> removeUserData() async {
    await StorageController.removeKey(
      key: "user",
    );
    await StorageController.removeKey(
      key: "token",
    );
  }

  static Future<String?> getDeviceNotificationToken() async {
    String? osUserID;
    int count = 0;
    while (osUserID == null) {
      count++;
      // await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
      // final status = await OneSignal.shared.getDeviceState();
      // osUserID = status?.userId;
      await Future.delayed(const Duration(milliseconds: 200));
      if (count == 5) {
        break;
      }
    }
    Logger().w(osUserID);
    return osUserID;
  }

  static setCartItemToLocaleStorage() async {
    List<Map<String, dynamic>> list = [];

    for (var item in Get.find<MainController>().cartItems) {
      list.add(item.toJson());
    }
    await StorageController.setData(key: catStorageKye, value: list);
  }

  static Future<void> getCartsFromLocaleStorage() async {
    List<CartItemModel> carts = [];
    if (StorageController.hasData(key: catStorageKye)) {
      for (var t in await StorageController.getData(key: catStorageKye)) {
        carts.add(CartItemModel.fromJson(t));
      }
      Get.find<MainController>().cartItems.value = carts
          .where((element) =>
              element.cityId == Get.find<MainController>().user.value!.cityId!)
          .toList();
    }
  }
}
