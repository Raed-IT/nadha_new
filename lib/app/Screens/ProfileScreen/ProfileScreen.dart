import 'package:avatar_glow/avatar_glow.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Screens/ProfileScreen/Componsnts/StoreProfileFieldComponent.dart';
import 'package:delevary/app/Screens/ProfileScreen/Componsnts/UserProfileFieldComponent.dart';
import 'package:delevary/app/Screens/ProfileScreen/ProfileScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Components/AppBarComponents/AppBarComponent.dart';
import '../../Components/DrawerComponents/DrawerComponent.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
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
                    delay: const Duration(milliseconds: 200),
                    begin: const Offset(20, 20),
                    duration: const Duration(seconds: 1),
                  ),
              Column(
                children: [
                  AppBarComponent(
                    title: "تعديل بياناتي",
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
                        20.verticalSpace,
                        AvatarGlow(
                          glowColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                          repeat: false,
                          glowCount: 1,
                          child: Material(
                            elevation: 9.0,
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              radius: 70.sp,
                              foregroundColor: Colors.red,
                              child: ImageCacheComponent(
                                image:
                                    '${Get.find<MainController>().user.value?.image}',
                              ),
                            ),
                          ).animate().scale(),
                        ),
                        10.verticalSpace,
                        Center(
                          child: Text(
                            "${Get.find<MainController>().user.value?.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Center(
                          child: Text(
                            "${Get.find<MainController>().user.value?.email}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        20.verticalSpace,
                        if (Get.find<MainController>().user.value?.store !=
                            null)
                          Obx(
                            () => Center(
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: ToggleButtons(
                                  isSelected: controller.selectedButton,
                                  onPressed: controller.onSelectedButton,
                                  children: <Widget>[
                                    SizedBox(
                                      width: (Get.width / 2) - 30,
                                      child: Center(
                                        child: Text("بيانتات المتجر"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (Get.width / 2) - 30,
                                      child: Center(
                                        child: Text("بيانات المستخدم"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Obx(
                          () => AnimatedSwitcher(
                            duration: 500.ms,
                            child: (controller.selectedIndex.value == 0)
                                ? const StoreProfileFieldsComponent()
                                : const UserProfileFieldsComponent(),
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
