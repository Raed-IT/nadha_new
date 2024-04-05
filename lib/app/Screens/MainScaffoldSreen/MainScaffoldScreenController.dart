import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Mixins/AddToCartMixin.dart';
import 'package:delevary/app/Screens/FavoriteScreen/FavoriteScreen.dart';
import 'package:delevary/app/Screens/HomeScreen/HomeScreen.dart';
import 'package:delevary/app/Screens/ProfileScreen/ProfileScreen.dart';
import 'package:delevary/app/Screens/SaleScreen/SaleScreen.dart';
import 'package:delevary/app/Screens/StoresScreens/StoresScreen/StoresScreen.dart';
import 'package:delevary/app/Services/CartService.dart';
import 'package:delevary/app/Services/deepLinkService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Services/PermissionService.dart';

class MainScaffoldScreenController extends GetxController with AddToCartMixin {
  final GlobalKey<CartIconKey> cartKey = GlobalKey();
  RxInt activePage = RxInt(Get.arguments?['index'] ?? 0);
  final CartService cartService = CartService();

  @override
  void onReady() {
    Get.find<MainController>().cart.listen((p0) {
      cartKey.currentState?.runCartAnimation(p0.length.toString());
    });
    Future.delayed(
        10.seconds, () => PermissionService.postNotificationPermission());
    super.onReady();
  }

  List<Widget> pages = [
    HomeScreen(),
    SaleScreen(),
    FavoriteScreen(),
    // ProfileScreen()
    StoresScreen()
  ];
  List<IconData> icons = [
    Icons.home_outlined,
    FontAwesomeIcons.fire,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.store,
  ];
  List<IconData> activeIcons = [
    Icons.home_outlined,
    FontAwesomeIcons.fire,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.store,
  ];

  void onTap(int index) {
    activePage.value = index;
  }

  addToCart(ProductModel product, GlobalKey key) {
    cartService.addToCard(product: product);
    addToCartAnimation(widgetKey: key, cartKey: cartKey);
  }
}
