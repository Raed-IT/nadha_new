import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:delevary/app/Mixins/AddToCartMixin.dart';
import 'package:delevary/app/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScaffoldScreenController extends GetxController with AddToCartMixin {
  final GlobalKey<CartIconKey> cartKey = GlobalKey();

  List<Widget> pages = [HomeScreen(), Container(), Container()];
  List<IconData> icons = [
    Icons.home_outlined,
    Icons.point_of_sale,
    Icons.favorite_border,
  ];
  List<IconData> activeIcons = [
    Icons.home,
    Icons.point_of_sale,
    Icons.favorite,
  ];
  RxInt activePage = RxInt(0);

  void onTap(int index) {
    activePage.value = index;
  }
}
