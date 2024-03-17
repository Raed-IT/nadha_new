import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Components/DrawerComponents/DrawerComponent.dart';
import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Screens/NotificationScreen/Components/NotificationsListComponent.dart';
import 'package:delevary/app/Screens/NotificationScreen/NotificationScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends GetView<NotificationScreenController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
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
                      openDrawer: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    Obx(() => (controller.paginationData.isNotEmpty)
                        ? Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: SizedBox(
                              height: 40.h,
                              child: MaterialButton(
                                minWidth: Get.width,
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () =>
                                    controller.deleteNotifications(context),
                                child: Text("مسح جميع الإشعارات"),
                              ),
                            ),
                          )
                        : SizedBox()),
                    const NotificationsListComponent()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
