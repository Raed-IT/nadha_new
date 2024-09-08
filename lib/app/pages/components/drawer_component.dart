import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helper_plugin/helper.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/helper.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/user_model.dart';
import 'package:nadha/app/pages/components/notification_widget.dart';
import 'package:nadha/app/route/routs.dart';
import 'package:nadha/app/them/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart' as dio;

// ignore: must_be_immutable
class DrawerComponent extends GetView<MainController> with ApiHelperMixin {
  DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().w(Get.find<MainController>().option.value?.phone);
    return Container(
      width: Get.width - (Get.width / 5),
      height: Get.height,
      color: AppColors.scaffold,
      padding: EdgeInsets.all(10.sp),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  " مرحبا ${Get.find<MainController>().user.value?.name ?? ''}",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
            Column(
              children: [
                if (Get.find<MainController>().user.value?.level ==
                    "vendor") ...[
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Get.find<MainController>().isActiveStore.value =
                          !Get.find<MainController>().isActiveStore.value;
                      changeStoreStatus();
                    },
                    child: Container(
                      color: AppColors.scaffold,
                      width: Get.width,
                      child: Obx(() => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "حالة المتجر${Get.find<MainController>().isActiveStore.value ? '  (مفتوح)' : ' ( مغلق )'}",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                activeColor: AppColors.warning,
                                value: Get.find<MainController>()
                                    .isActiveStore
                                    .value,
                                onChanged: (val) {
                                  Get.find<MainController>()
                                      .isActiveStore
                                      .value = val;
                                  changeStoreStatus();
                                },
                              )
                            ],
                          )),
                    ),
                  ),
                  Divider(),
                ],

                if (Get.find<MainController>().isStore)
                  buildItem(
                    title: "الطلبات الواردة  ",
                    icon: Icons.add_business_sharp,
                    onTap: () => Get.toNamed(AppRoutes.ORDERS_SCREEN,
                        arguments: <String, bool>{"isStore": true}),
                  ),
                if (Get.find<MainController>().isAdmin)
                  buildItem(
                    title: "جميع الطلبات ",
                    icon: Icons.add_business_sharp,
                    onTap: () => Get.toNamed(AppRoutes.ORDERS_SCREEN,
                        arguments: <String, bool>{"isAdmin": true}),
                  ),
                buildItem(
                    title: "تعديل الملف الشخصي ",
                    icon: Icons.account_circle,
                    onTap: () => Get.toNamed(AppRoutes.PROFILE_SCREEN)),
                buildItem(
                    title: "عرض المتاجر  ",
                    icon: FontAwesomeIcons.table,
                    onTap: () => Get.toNamed(AppRoutes.STORE_SCREEN)),
                if (Get.find<MainController>().user.value?.level == "vendor")
                  buildItem(
                      title: "متجري  ",
                      icon: FontAwesomeIcons.store,
                      onTap: () => Get.toNamed(AppRoutes.VENDOR_STORE_SCREEN)),
                buildItem(
                    title: "صفحة الرصيد ",
                    icon: Icons.account_balance_wallet,
                    onTap: () => Get.toNamed(AppRoutes.BALANCE_SCREEN)),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    buildItem(
                        title: "الاشعارات ",
                        icon: Icons.notifications_active_outlined,
                        onTap: () => Get.toNamed(AppRoutes.NOTIFICATIONS)),
                    const NotificationWidget(
                      icon: Icons.notifications_active,
                    )
                  ],
                ),

                40.verticalSpace,
                buildItem(
                  title: "تواصل مع الإدارة ",
                  icon: FontAwesomeIcons.whatsapp,
                  iconColor: Colors.green,
                  onTap: () {
                    launchUrl(Uri.parse(
                        "https://wa.me/${Get.find<MainController>().option.value?.phone ?? Get.find<MainController>().setting?.value.phone}"));
                  },
                ),
                // buildItem(
                //     title: "الشركه المطورة ",
                //     icon: Icons.sailing_outlined,
                //     onTap: () {}),
              ],
            ),
            Container(),
            Container(),
            Column(
              children: [
                Divider(),
                buildItem(
                    title: "تسجيل الخروج ",
                    icon: Icons.login,
                    onTap: () async {
                      EasyLoading.show();
                      GoogleSignIn goo = GoogleSignIn();
                      await goo.signOut();
                      Get.find<MainController>().cartItems.clear();
                      Helper.setCartItemToLocaleStorage();
                      Helper.removeUserData();
                      await Future.delayed(const Duration(seconds: 1), () {
                        EasyLoading.dismiss();
                        Get.offAllNamed(AppRoutes.AUTH_SCREEN);
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(
      {required String title,
      required IconData icon,
      Color? iconColor,
      required void Function()? onTap}) {
    return ListTile(
      onTap: () {
        if (onTap != null) {
          Get.back();
          onTap();
        }
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title),
          SizedBox(
            width: 10.w,
          ),
          Icon(
            icon,
            color: iconColor,
          )
        ],
      ),
    );
  }

  Future<void> changeStoreStatus() async {
    EasyLoading.show();
    await postDataDio(url: ApiRouts.stores, data: dio.FormData.fromMap({}));
    EasyLoading.dismiss();
  }

  @override
  void getDataFromPostDioUsing(json) {
    Fluttertoast.showToast(msg: "تم تعديل حالة المتجر ");
    Helper.saveUserData(
        user: UserModel.fromJson(json['data']['user']),
        token: Get.find<MainController>().token.value ?? '');
  }
}
