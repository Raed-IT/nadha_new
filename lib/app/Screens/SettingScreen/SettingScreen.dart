import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Components/DrawerComponents/DrawerComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/SettingScreen/SettingScreenController.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingScreen extends GetView<SettingScreenController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerComponent(),
      body: Builder(builder: (context) {
        return Column(
          children: [
            AppBarComponent(
              openDrawer: () => Scaffold.of(context).openDrawer(),
              title: "الإعدادات",
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  children: [
                    BigUserCard(
                      userName:
                          "${Get.find<MainController>().user.value?.name}",
                      userProfilePic: CachedNetworkImageProvider(
                          "${Get.find<MainController>().user.value?.image}"),
                      cardActionWidget: SettingsItem(
                        icons: Icons.edit,
                        iconStyle: IconStyle(
                          withBackground: true,
                          borderRadius: 50.sp,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        title: "تعديل بياناتي",
                        subtitle: "يمكنك الضغط لتعديل بياناتك",
                        titleStyle: TextStyle(fontSize: 15.sp),
                        subtitleStyle: TextStyle(fontSize: 10.sp),
                        onTap: () => Get.toNamed(AppRoutes.profileScreen),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    SettingsGroup(
                      iconItemSize: 35.sp,
                      items: [
                        SettingsItem(
                          onTap: () => controller.treggerDarkMode(),
                          icons: Icons.dark_mode_rounded,
                          iconStyle: IconStyle(
                            iconsColor: Colors.white,
                            withBackground: true,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          title: 'الوضع المظلم',
                          subtitle: "اختر الوضع يدويا ",
                          trailing: Obx(
                            () => Switch.adaptive(
                              value:
                                  Get.find<MainController>().themeMode.value ==
                                      ThemeMode.dark,
                              onChanged: (value) =>
                                  controller.treggerDarkMode(),
                            ),
                          ),
                        ),
                        SettingsItem(
                          onTap: () => controller.changeDarkModeToSystem(),
                          icons: Icons.dark_mode_rounded,
                          iconStyle: IconStyle(
                            iconsColor: Colors.white,
                            withBackground: true,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          title: 'وضع النظام',
                          subtitle: "سيتم اختيار الوضع المظلم من نظام التشغيل ",
                          trailing: Obx(
                            () => Switch.adaptive(
                              value:
                                  Get.find<MainController>().themeMode.value ==
                                      ThemeMode.system,
                              onChanged: (value) {
                                if (value) {
                                  Get.find<MainController>().themeMode.value =
                                      ThemeMode.system;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SettingsGroup(
                      settingsGroupTitle: "    الحساب",
                      items: [
                        SettingsItem(
                          onTap: () => LocaleStorageService.logOut(),
                          icons: Icons.exit_to_app_rounded,
                          title: "تسجيل الخروج ",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
