import 'package:delevary/app/Components/AppBarComponents/v2/appBar/appbar_with_title.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/v2/categories_screen/categories_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoriesScreen extends GetView<CategoriesScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWithTitleComponent(title: "الفئات"),
          Expanded(
            child: GridView.count(
              childAspectRatio: 89 / 77,
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 3,
              padding: EdgeInsets.all(24.w),
              children: [
                ...controller.categories.map((cat) => _buildCard(cat))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.categoryProducts,
            arguments: {"category": category});
      },
      child: SizedBox(
        height: 50.h,
        width: Get.width,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network(
                fit: BoxFit.cover,
                "${category.image}",
                height: 40.h,
                width: 40.w,
              ),
                Text(category.name ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
