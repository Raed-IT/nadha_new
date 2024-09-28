import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppBarWithLogoComponent extends StatelessWidget {
  final bool? showArrow;
  const AppBarWithLogoComponent({super.key, this.showArrow});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: SizedBox(),
            ),
            SvgPicture.asset(
              "assets/svg/logo.svg",
              height: 36.h,
              width: 120.w,
            ).animate().slideY(duration: 200.ms, begin: -0.2),
            IconButton(
              onPressed: () => Get.back(),
              icon: showArrow==true?const Icon(FontAwesomeIcons.arrowLeft):SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
