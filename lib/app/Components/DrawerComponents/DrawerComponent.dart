import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.profileScreen);
                  },
                  child: ImageCacheComponent(
                          borderRadius: BorderRadius.circular(150.sp),
                          height: 70.sp,
                          width: 70.sp,
                          image: Get.find<MainController>().user.value!.image!)
                      .animate()
                      .slideY(begin: 1)
                      .fadeIn(),
                ),
                10.verticalSpace,
                Text(
                  "${Get.find<MainController>().user.value?.name}",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${Get.find<MainController>().user.value?.email}",
                  style: TextStyle(fontSize: 15.sp),
                ),
              ],
            ),
          ),
          40.verticalSpace,
          Divider(indent: 10.w, endIndent: 10.w),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  20.verticalSpace,
                  Container(
                    margin: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(),
                    ),
                    child: buildItem(
                      rout: "",
                      context: context,
                      title: "نسخ رابط متجري ",
                      icon: FontAwesomeIcons.copy,
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                              text:
                                  "${ApiRoute.domin}/stores/${Get.find<MainController>().user.value?.store?.uniqName}"),
                        );
                        ToastService.showSuccessToast(
                            context: context, title: "تم نسرابط المتجر");
                      },
                    ),
                  ),
                  Obx(
                    () => Get.find<MainController>().user.value?.store != null
                        ? buildItem(
                            rout: AppRoutes.showStore,
                            context: context,
                            title: "متجري ",
                            icon: FontAwesomeIcons.store,
                            onTap: () => Get.toNamed(AppRoutes.store),
                          )
                        : Container(),
                  ),
                  if (Get.find<MainController>().user.value!.isDelivery!)
                    buildItem(
                      rout: AppRoutes.deliveryOrders,
                      context: context,
                      title: "طلبات قيد التوصيل",
                      icon: FontAwesomeIcons.motorcycle,
                      onTap: () => Get.toNamed(AppRoutes.deliveryOrders),
                    ),
                  buildItem(
                    rout: AppRoutes.favorites,
                    context: context,
                    title: "المفضلة",
                    icon: FontAwesomeIcons.heart,
                    onTap: () => Get.toNamed(AppRoutes.favorites),
                  ),
                  buildItem(
                    rout: AppRoutes.addresses,
                    context: context,
                    title: "عناويني ",
                    icon: FontAwesomeIcons.mapLocationDot,
                    onTap: () => Get.toNamed(AppRoutes.addresses),
                  ),
                  buildItem(
                    rout: AppRoutes.notifications,
                    context: context,
                    title: "الإشعارات",
                    icon: Icons.notifications_active_outlined,
                    onTap: () => Get.toNamed(AppRoutes.notifications),
                  ),
                  buildItem(
                    rout: AppRoutes.orders,
                    context: context,
                    title: "طلباتي",
                    icon: FontAwesomeIcons.firstOrderAlt,
                    onTap: () => Get.toNamed(AppRoutes.orders),
                  ),
                  buildItem(
                    rout: AppRoutes.stores,
                    context: context,
                    title: "المتاجر",
                    icon: Icons.storefront_outlined,
                    onTap: () => Get.toNamed(AppRoutes.stores),
                  ),
                  buildItem(
                    rout: AppRoutes.setting,
                    context: context,
                    title: "الإعدادات",
                    icon: Icons.settings,
                    onTap: () => Get.toNamed(AppRoutes.setting),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem({
    required String title,
    required IconData icon,
    required Function onTap,
    required BuildContext context,
    required String rout,
  }) {
    return GestureDetector(
      onTap: () {
        Get.back();
        onTap();
      },
      // child: SizedBox(
      //   height: 60.h,
      //   width: Get.width,
      //   child: Card(
      //     margin: EdgeInsets.symmetric(vertical: 7.sp, horizontal: 5.sp),
      //     child: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 10.sp),
      //       child: Row(
      //         children: [
      //           Icon(icon,
      //               size: 20.sp, color: Theme.of(context).colorScheme.primary),
      //           10.horizontalSpace,
      //           Text(
      //             title,
      //             style: TextStyle(fontSize: 15.sp),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        selected: Get.currentRoute == rout,
      ),
    );
  }
}
