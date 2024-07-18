import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Components/DrawerComponents/DrawerComponent.dart';
import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Screens/NotificationScreen/Components/NotificationsListComponent.dart';
import 'package:delevary/app/Screens/NotificationScreen/Components/deleteNotificationsDialog.dart';
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
            child: Column(
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            minWidth: Get.width,
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () => showDeleteNotificationsDialog(
                                context: context,
                                onDelete: () {
                                  Get.back();
                                  controller.deleteNotifications(context);
                                }),
                            child: Text(
                              "مسح جميع الإشعارات",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .background,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox()),
                const NotificationsListComponent()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
