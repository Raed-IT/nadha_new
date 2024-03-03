import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Components/GridCardComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/GridListLoading.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Screens/HomeScreen/HomeScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Components/DrawerComponents/DrawerComponent.dart';
import '../../Components/SlidersComponent.dart';

class HomeScreen extends GetView<HomeScreenController> {
  HomeScreen({super.key});

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerComponent(),
      body: Builder(
        builder: (context) => Container(
          height: Get.height,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              AppBarComponent(openDrawer: () {
                Scaffold.of(context).openDrawer();
              }),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SliderComponent(
                      sliders: controller.sliders,
                      controller: PageController(),
                      isLoad: controller.isLoad,
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.sp),
                      child: GridListComponent<CategoryModel>(
                        items: controller.categories,
                        isLoad: controller.isLoad,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
