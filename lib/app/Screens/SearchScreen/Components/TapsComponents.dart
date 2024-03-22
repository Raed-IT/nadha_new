import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:delevary/app/Screens/SearchScreen/SearchScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TapsSearchComponent extends GetView<SearchScreenController> {
  const TapsSearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomSlidingSegmentedControl<int>(
        initialValue: controller.indexTaps.value,
        children: {
          0: SizedBox(
            width: 80.w,
            child: const AutoSizeText(
              ' متاجر',
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          1: SizedBox(
            width: 80.w,
            child: const AutoSizeText(
              ' منتجات',
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          2: SizedBox(
            width: 80.w,
            child: const AutoSizeText(
              ' عروض',
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        },
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        thumbDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 2.0.sp,
              spreadRadius: 1.0.sp,
              offset: Offset(
                0.0,
                2.0.sp,
              ),
            ),
          ],
        ),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInToLinear,
        onValueChanged: (v) {
        controller.indexTaps.value=v;
        },
      ),
    );
  }
}
