import 'package:delevary/app/Screens/SearchScreen/SearchScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

  class LoaderSearchComponent extends GetView<SearchScreenController> {
  const LoaderSearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoadPaginationData.value
        ? Padding(
            padding: EdgeInsets.only(top: 150.h),
            child: Lottie.asset('assets/json/loader.json',
                width: 200.w, height: 200.h),
          )
        : Container());
  }
}
