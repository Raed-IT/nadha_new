import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:delevary/app/data/Models/CityModel.dart';
import 'package:delevary/app/data/Models/SettingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper/data/constant.dart';
import 'Models/CartItemModel.dart';

class MainController extends GetxController {
  // @override
  // void onReady() {
  //   LocaleStorageService.logOut();
  //   super.onReady();
  // }

  Rxn<AddressModel> selectedAddress = Rxn();

  bool isSelectedAddress ({ required AddressModel address}){
    return selectedAddress.value?.id==address.id;
  }
  Rxn<String> token = Rxn(null);
  Rxn<UserModel> user = Rxn(null);
  Rxn<SettingModel> setting = Rxn<SettingModel>();
  RxList<CityModel> cities = RxList<CityModel>([]);
  RxList<CartItemModel> cart = RxList<CartItemModel>([]);
  Rx<ThemeMode> themeMode = Rx(ThemeMode.light);

  @override
  void onInit() {
    token.listen((p0) {
      HelperConstant.globalHeader['Authorization'] = 'Bearer $p0';
    });
    LocaleStorageService.getThemMode();
    super.onInit();
  }
}
