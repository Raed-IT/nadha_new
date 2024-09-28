import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppBarWithTitleComponent extends StatelessWidget {
  final String title;

  const AppBarWithTitleComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 24.w,right: 24.w,left: 24.w),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17.sp),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(FontAwesomeIcons.arrowLeft),
            )
          ],
        ),
      ),
    );
  }
}
