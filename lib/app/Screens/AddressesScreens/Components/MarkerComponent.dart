import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MarkerComponent extends StatelessWidget {
  final String? image;

  const MarkerComponent({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Icon(
            FontAwesomeIcons.locationPin,
            size: 100.sp,
            color: Theme.of(context).colorScheme.primary,
          ),

            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: ImageCacheComponent(
                image: "${Get.find<MainController>().user.value?.image}",
                width: 50.sp,
                height: 50.sp,
                borderRadius: BorderRadius.circular(10000.sp),
              ),
            ),
        ],
      ),
    );
  }
}
