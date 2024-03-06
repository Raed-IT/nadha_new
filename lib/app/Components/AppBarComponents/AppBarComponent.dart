import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
              Row(
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
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
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .slideX(begin: -1, duration: Duration(milliseconds: 400)),
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
                            child: Icon(
                              CupertinoIcons.search,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ),
                    ).animate().scale(begin: Offset(1, 1)),
                  const Spacer(),
                  (showLogo)
                      ? Image.asset(
                          fit: BoxFit.contain,
                          height: 60.h,
                          width: 150.w,
                          "assets/images/artboard.png",
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
                          begin: 1, duration: Duration(milliseconds: 400)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
