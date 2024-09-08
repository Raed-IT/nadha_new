import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/them/app_colors.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // Get.find<MainController>().notificationsCount.value=10;
    return Obx(
      () => Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            size: 25.sp,
            color: AppColors.scaffold,
          ),
          Get.find<MainController>().notificationsCount.value > 0
              ? Positioned(
                  top: 0,
                  right: 100.w,
                  child: CircleAvatar(
                    backgroundColor: AppColors.danger,
                    radius: 10.sp,
                    child: Text(
                      "${Get.find<MainController>().notificationsCount.value}",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.scaffold,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
