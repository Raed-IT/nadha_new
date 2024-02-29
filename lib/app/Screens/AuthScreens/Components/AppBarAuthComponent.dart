import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppBarAuthComponent extends StatelessWidget {
  final Function() onAnotherTap;
  final String title;

  const AppBarAuthComponent(
      {super.key, required this.onAnotherTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      width: Get.width,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              FontAwesomeIcons.arrowRight,
              size: 20.sp,
            ),
          ).animate().slideX(begin: 1, duration: Duration(milliseconds: 300)),
          const Spacer(),
          IconButton.outlined(
            onPressed: onAnotherTap,
            icon: Text(
              title,
              style: TextStyle(fontSize: 12.sp),
            ),
          )
              .animate()
              .scale(
                begin: const Offset(0, 0),
                duration: const Duration(milliseconds: 200),
              )
              .slideY(begin: -1),
        ],
      ),
    );
  }
}
