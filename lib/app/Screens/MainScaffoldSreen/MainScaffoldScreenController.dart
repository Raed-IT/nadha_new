import 'package:delevary/app/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScaffoldScreenController extends GetxController {
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
