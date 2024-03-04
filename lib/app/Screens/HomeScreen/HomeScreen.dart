import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Components/GridCardComponent.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/HomeScreen/HomeScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Components/DrawerComponents/DrawerComponent.dart';
import '../../Components/SlidersComponent.dart';
import '../CategoriesScreen/CategoriesScreenController.dart';

class HomeScreen extends GetView<HomeScreenController> {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerComponent(),
      body: Builder(
        builder: (context) => Container(
          height: Get.height,
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.1,
                    repeat: ImageRepeat.repeat,
                    image: AssetImage('assets/images/bg.png'),
                  ),
                ),
              ).animate().blur(
                    delay: Duration(milliseconds: 500),
                    begin: const Offset(20, 20),
                    duration: const Duration(seconds: 2),
                  ),
              Column(
                children: [
                  AppBarComponent(
                    openDrawer: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SliderComponent(
                          sliders: controller.sliders,
                          controller: PageController(),
                          isLoad: controller.isLoad,
                        ),
                        20.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10.sp)),
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.sp,
                          ),
                          height: 80.h,
                          child: Center(
                            child: Image.asset(
                              "assets/images/logo.png",
                              width: Get.width,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        20.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.sp),
                          child: GridListComponent<CategoryModel>(
                            prifexHero: "categories",
                            items: controller.categories,
                            isLoad: controller.isLoad,
                            onTap: (CategoryModel item) {
                              if (item.hasChildren!) {
                                Get.toNamed(
                                  AppRoutes.categories,
                                  arguments: {
                                    "category": item,
                                  },
                                );
                                Get.put(CategoriesScreenController(),
                                    tag: "category${item.id}");
                              } else {
                                Get.toNamed(AppRoutes.categoryProducts,
                                    arguments: {"category": item});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
