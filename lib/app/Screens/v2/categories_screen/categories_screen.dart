import 'package:delevary/app/Components/AppBarComponents/v2/appBar/appbar_with_title.dart';
import 'package:delevary/app/Screens/v2/categories_screen/categories_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends GetView<CategoriesScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
            AppBarWithTitleComponent(title: "الفئات")
        ],
      ),
    );
  }
}
