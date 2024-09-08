import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nadha/app/data/model/notification_model.dart';
import 'package:nadha/app/pages/notifications_screen/notifications_controller.dart';
import 'package:nadha/app/them/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/appbar.dart';
import '../components/bottom_nav_component.dart';

class NotificationsScreen extends GetView<NotificationsScreenController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.buildScreen(
      // isClosable: true,
      extendBody: true,
      bottomNavigationBar: BottomNavComponent(),
      widgets: [
        SliverToBoxAdapter(
          child: Obx(
            () => (controller.isLoadPagination.value)
                ? Column(
                    children: List.generate(100, (index) => index)
                        .map(
                          (e) => Opacity(
                            opacity: 0.5,
                            child: CardLoading(
                              margin: EdgeInsets.all(10.w),
                              height: 100.h,
                              width: Get.width,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.sp),
                              ),
                            ),
                          ),
                        )
                        .toList()
                        .animate()
                        .scale(
                          duration: const Duration(milliseconds: 200),
                        ),
                  )
                : (controller.paginationData.isNotEmpty)
                    ? Column(
                        children: controller.paginationData
                            .map(
                              (notification) => buildNotificationCard(
                                  notification: notification),
                            )
                            .toList()
                            .animate()
                            .slideY(
                              begin: 1,
                              duration: 300.ms,
                            )
                            .scale(),
                      )
                    : SizedBox(
                        height: 300.h,
                        child: Column(
                          children: [
                            Expanded(
                              child: Lottie.asset(
                                'assets/json/nodata.json',
                              ),
                            ),
                            Text(
                              "لايوجد اشعارات ",
                              style: TextStyle(
                                  fontSize: 22.sp, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ).animate().slide(
                          begin: const Offset(0, 0.3),
                        ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 50.h,
          ),
        )
      ],
      appBar: const SliverToBoxAdapter(
        child: AppBarComponent(
          // showBackIcon: false,
          title: "الإشعارات",
        ),
      ),
    );
  }

  Widget buildNotificationCard({required NotificationModel notification}) {
    return Container(
      constraints: BoxConstraints(minHeight: 100.h),
      width: Get.width,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: ListTile(
          title: Text("${notification.title}"),
          subtitle: Text("${notification.msg}"),
          trailing: Visibility(
            visible: notification.isUrl ?? false,
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.golang,
                size: 40.sp,
                color: AppColors.warning,
              ),
              onPressed: () {
                launchUrl(Uri.parse("${notification.url}"),
                    mode: LaunchMode.platformDefault);
              },
            ),
          ),
        ),
      ),
    );
  }
}
