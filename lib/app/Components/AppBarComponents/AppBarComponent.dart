import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AppBarComponent extends StatelessWidget {
  final Function openDrawer;
  final Function? onSearch;
  final String? title;
  final bool? showSearch;
  final bool showLogo;

  const AppBarComponent(
      {super.key,
      required this.openDrawer,
      this.title,
      this.showSearch,
      this.onSearch,
      this.showLogo = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 60.h,
        width: Get.width,
        child: Container(
          color: Colors.transparent,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (showLogo)
                        ? SvgPicture.asset(
                            fit: BoxFit.contain,
                            height: 43.h,
                            "assets/svg/logo.svg",
                          )
                        : GestureDetector(
                            onTap: () => Get.toNamed(
                              AppRoutes.profileScreen,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.sp),
                              child: ImageCacheComponent(
                                borderRadius: BorderRadius.circular(10.sp),
                                height: 40.sp,
                                width: 40.sp,
                                image:
                                    "${Get.find<MainController>().user.value?.image}",
                              ),
                            ),
                          ).animate().slideX(
                            begin: 1,
                            duration: const Duration(milliseconds: 400)),
                    const Spacer(),
                    if (title != null)
                      Text(
                        title!,
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                    if (title != null) const Spacer(),
                    if (showSearch != null && showSearch!)
                      GestureDetector(
                        onTap: () {
                          if (onSearch != null) {
                            onSearch!();
                          } else {
                            Get.toNamed(AppRoutes.searchScreen);
                          }
                        },
                        child: SizedBox(
                          height: 50.sp,
                          width: 50.sp,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              // child: Lottie.asset("assets/json/search.json",
                              //     width: 40.w, repeat: false),
                              child: Icon(
                                FontAwesomeIcons.search,
                                size: 22.sp,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ),
                      ).animate().scale(
                            begin: const Offset(1, 1),
                          ),
                    GestureDetector(
                      onTap: () => openDrawer(),
                      child: SizedBox(
                        height: 50.sp,
                        width: 50.sp,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Icon(
                              FontAwesomeIcons.bars,
                              size: 22.sp,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ),
                    ).animate().slideX(
                        begin: -1, duration: const Duration(milliseconds: 400)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
