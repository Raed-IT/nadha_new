import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';
import 'package:delevary/app/Data/Models/SettingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper/data/constant.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'Models/CartItemModel.dart';

class MainController extends GetxController {
  // @override
  // void onReady() {
  //   LocaleStorageService.logOut();
  //   super.onReady();
  // }
  List<CategoryModel> storeCategories = [];
  Rxn<AddressModel> selectedAddress = Rxn();
  late PackageInfo packageInfo;

  bool isSelectedAddress({required AddressModel address}) {
    return selectedAddress.value?.id == address.id;
  }

  Rxn<String> token = Rxn(null);
  bool isReadStarterPages =false;
  Rxn<UserModel> user = Rxn(null);
  Rxn<SettingModel> setting = Rxn<SettingModel>();
  RxList<CityModel> cities = RxList<CityModel>([]);
  RxList<CartItemModel> cart = RxList<CartItemModel>([]);
  Rx<ThemeMode> themeMode = Rx(ThemeMode.light);

  @override
  void onInit() {

    token.listen((p0) {
      HelperConstant.token = p0;
    });
    LocaleStorageService.getThemMode();
    super.onInit();
  }
}
