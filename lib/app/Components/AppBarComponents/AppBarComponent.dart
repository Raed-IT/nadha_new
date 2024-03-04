import 'package:cached_network_image/cached_network_image.dart';
import 'package:delevary/app/Components/SafeAreaComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../ChachImageComponent.dart';

class AppBarComponent extends StatelessWidget {
  final Function openDrawer;
  final String? title;

  const AppBarComponent({super.key, required this.openDrawer, this.title});

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
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.profileScreen,),
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
                  )
                      .animate()
                      .slideX(begin: 1, duration: Duration(milliseconds: 400)),
                  const Spacer(),
                  if (title != null)
                    Text(
                      title!,
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                  if (title != null) const Spacer(),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
