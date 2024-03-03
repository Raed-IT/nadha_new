import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/HorizontalListLoading.dart';
import 'package:delevary/app/Components/LoadingComponents/VerticalListLoadingListLoading.dart';
import 'package:delevary/app/Screens/HomeScreen/HomeScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Components/DrawerComponents/DrawerComponent.dart';
import '../../Components/SlidersComponent.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: DrawerComponent(),
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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SliderComponent(
                        sliders: controller.sliders,
                        controller: PageController(),
                        isLoad: controller.isLoad,
                      ),
                      HorizontalListLoading()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
