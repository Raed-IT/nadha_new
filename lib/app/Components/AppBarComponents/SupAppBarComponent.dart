import 'package:delevary/app/Components/SafeAreaComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SupAppBarComponent extends StatelessWidget {
  const SupAppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredSafeArea(
      child: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            TextField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50.h,
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.sp),
                        bottomLeft: Radius.circular(10.sp),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.search),
                    ),
                  ),
                ).animate().slideX(begin: 1),
                Text("sdsd"),
                SizedBox(
                  height: 50.h,
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.sp),
                        bottomRight: Radius.circular(10.sp),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.search),
                    ),
                  ),
                ).animate().slideX(begin: -1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
