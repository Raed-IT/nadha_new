import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                SizedBox(
                  height: 130.h,
                  child: ImageCacheComponent(
                    image: "${Get.find<MainController>().user.value?.image}",
                    imageColor: Theme.of(context).colorScheme.background,
                    width: 130.w,
                  ),
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
                20.verticalSpace,
                buildItem(
                  context: context,
                  title: "الإعدادات",
                  icon: Icons.settings,
                  onTap: () => Get.toNamed(AppRoutes.setting),
                ),
                buildItem(
                  context: context,
                  title: "عناويني ",
                  icon: FontAwesomeIcons.mapLocationDot,
                  onTap: () => Get.toNamed(AppRoutes.addresses),
                ),
                buildItem(
                  context: context,
                  title: "الإشعارات",
                  icon: Icons.notifications_active_outlined,
                  onTap: () => Get.toNamed(AppRoutes.notifications),
                ),
                buildItem(
                  context: context,
                  title: "طلباتي",
                  icon: FontAwesomeIcons.firstOrderAlt,
                  onTap: () => Get.toNamed(AppRoutes.orders),
                ),
                buildItem(
                  context: context,
                  title: "المتاجر",
                  icon: FontAwesomeIcons.store,
                  onTap: () => Get.toNamed(AppRoutes.stores),
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
      required Function onTap,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Get.back();
        onTap();
      },
      child: SizedBox(
        height: 60.h,
        width: Get.width,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 7.sp, horizontal: 5.sp),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Row(
              children: [
                Icon(icon,
                    size: 20.sp, color: Theme.of(context).colorScheme.primary),
                10.horizontalSpace,
                Text(
                  title,
                  style: TextStyle(fontSize: 15.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
