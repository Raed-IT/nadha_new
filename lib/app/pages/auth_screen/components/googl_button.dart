import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/auth_screen/auth_controller.dart';

import '../../../them/app_colors.dart';

class GoogleButtonComponent extends GetView<AuthScreenController> {
  final bool  showCityDialog;
  const GoogleButtonComponent( {super.key,this.showCityDialog=false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        GestureDetector(
          onTap: () => controller.getGoogleAccount(showCityDialog:showCityDialog ),
          child: Container(
            width: Get.width,
            height: 55.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.sp),
                ),
                color: AppColors.fill),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.google,
                  size: 25.sp,
                  color: AppColors.danger,
                ),
                SizedBox(
                  width: 30.w,
                ),
                Text(
                  "سجل باستخدام غوغل",
                  style: TextStyle(color: AppColors.danger, fontSize: 17.sp),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
