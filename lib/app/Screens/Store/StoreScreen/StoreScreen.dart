import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/StoreScreen/Components/NoDataComponent.dart';
import 'package:delevary/app/Screens/Store/StoreScreen/Components/StatisticStoreComponent.dart';
import 'package:delevary/app/Screens/Store/StoreScreen/StoreScreenController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../Components/AppBarComponents/AppBarComponent.dart';
import '../../../Components/DrawerComponents/DrawerComponent.dart';
import 'Components/StoreCardComponent.dart';
import 'package:animated_number/animated_number.dart';

class StoreScreen extends GetView<StoreScreenController> {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

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
                    delay: const Duration(milliseconds: 500),
                    begin: const Offset(20, 20),
                    duration: const Duration(seconds: 2),
                  ),
              Column(
                children: [
                  AppBarComponent(
                    title: "متجري",
                    openDrawer: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(0),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 280.h,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () => Get.toNamed(
                                    AppRoutes.profileScreen,
                                    arguments: {'index': 1}),
                                child: const StoreCardComponent(),
                              ),
                              Positioned(
                                top: 30.sp,
                                left: 30.sp,
                                child: GestureDetector(
                                  onTap: () => controller.getFreshData(),
                                  child: Center(
                                    child: Icon(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 30.sp,
                                      FontAwesomeIcons.refresh,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Obx(
                          () => (controller.isLoad.value)
                              ? SizedBox(
                                  height: 500.h,
                                  width: Get.width,
                                  child: Center(
                                    child: Lottie.asset(
                                        "assets/json/loader.json",
                                        height: 150.h),
                                  ),
                                )
                              : (controller.statistics.value != null)
                                  ? StatisticStoreComponent()
                                  : NoDataStoreComponent(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: MaterialButton(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            height: 50.h,
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () => Get.toNamed(
                              AppRoutes.showStore,
                              arguments: {"store": controller.store},
                            ),
                            child: Text(
                              "عرض متجري كزائر ",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ),
                        )
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
