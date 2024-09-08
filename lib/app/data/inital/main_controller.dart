import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:helper_plugin/utilitis/constats.dart';
import 'package:nadha/app/data/cart_mixin.dart';
import 'package:nadha/app/data/helper.dart';
import 'package:nadha/app/data/model/option_model.dart';
import 'package:nadha/app/data/model/setting_model.dart';
import 'package:nadha/app/data/model/user_model.dart';
import 'package:nadha/app/route/routs.dart';
import '../model/address_model.dart';
import '../model/city_model.dart';

class MainController extends GetxController
    with CartMixin, SingleGetTickerProviderMixin {
  RxBool isActiveStore = RxBool(false);
  RxInt currentBottomNavIndex = RxInt(2);
  RxList<CityModel> cities = RxList([]);
  Rx<SettingModel>? setting;
  RxInt notificationsCount = RxInt(0);
  Rxn<String> token = Rxn();
  Rxn<UserModel> user = Rxn();
  List<AddressModel> addresses = [];
  Rxn<AddressModel> selectedAddress = Rxn();
  Rxn<OptionModel> option = Rxn(
    OptionModel(isOpen: true, msgClose: "المتجر مغلق "),
  );
  late TabController bottomNavBarController;

  bool get isStore =>
      Get.find<MainController>().user.value != null &&
      Get.find<MainController>().user.value?.level == "vendor";

  bool get isAdmin =>
      Get.find<MainController>().user.value != null &&
      Get.find<MainController>().user.value?.level == "admin";

  @override
  void onInit() {
    bottomNavBarController =
        TabController(length: 3, vsync: this, initialIndex: 2);
    ConstantHelperMadaFlutter.isLogOut.listen((p0) {
      if (p0) {
        Helper.removeUserData();
        ConstantHelperMadaFlutter.isLogOut.value = false;
        Get.offAllNamed(AppRoutes.AUTH_SCREEN);
      }
    });

    token.listen((p0) {
      ConstantHelperMadaFlutter.token = token.value;
    });
    currentBottomNavIndex.listen((index) {
      checkIndex(index);
    });
    super.onInit();
  }

  void checkIndex(int index) {
    bottomNavBarController.animateTo(
      index,
    );
    switch (index) {
      case 0:
        Get.offNamed(AppRoutes.ORDERS_SCREEN);
        break;
      case 1:
        Get.offNamed(
          AppRoutes.OFFER_SCREEN,
        );
        break;
      case 2:
        Get.offNamed(AppRoutes.HOME_SCREEN);
        break;
      case 3:
        Get.offNamed(AppRoutes.NOTIFICATIONS);
        break;
    }
  }
}
