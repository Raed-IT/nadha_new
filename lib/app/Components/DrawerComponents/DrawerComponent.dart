import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - (Get.width / 3),
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: Get.height / 3,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ImageCacheComponent(
                  image: "${Get.find<MainController>().user.value?.image}",
                  imageColor: Theme.of(context).colorScheme.background,
                  width: 100.w,
                ),
                AutoSizeText(
                  "${Get.find<MainController>().user.value?.name}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontSize: 20.sp,
                  ),
                ),
                AutoSizeText(
                  "${Get.find<MainController>().user.value?.email}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontSize: 15.sp,
                  ),
                ),
                25.verticalSpace,
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                buildItem(
                  title: "الإعدادات",
                  icon: Icons.settings,
                  onTap: () => Get.toNamed(AppRoutes.setting),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(
      {required String title,
      required IconData icon,
      required Function onTap}) {
    return GestureDetector(
      onTap: () {
        Get.back();
        onTap();
      },
      child: SizedBox(
        height: 50.h,
        width: Get.width,
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Row(
              children: [
                Icon(icon),
                10.horizontalSpace,
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
