import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nopsuite_carousel_slider/effects/worm_effect.dart';
import 'package:nopsuite_carousel_slider/nopsuite_carousel_slider.dart';

import '../Data/Models/SliderModel.dart';

class SliderComponent extends StatelessWidget {
  final List<SliderModel> sliders;
  final PageController controller;
  final RxBool isLoad;
  final double height = 150.h;

  SliderComponent(
      {super.key,
      required this.sliders,
      required this.controller,
      required this.isLoad});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (isLoad.value)
          ? CardLoadingComponent(
              height: height + 20.h,
            )
          : NopSuiteCarouselSlider(
              height: height,
              controller: controller,
              count: sliders.length,
              itemBuilder: sliders
                  .map(
                    (e) => ImageCacheComponent(
                        height: height,
                        image:
                            "https://www.gstatic.com/webp/gallery3/1.sm.png"),
                  )
                  .toList(),
              effect: WormEffect(
                dotHeight: 8.sp,
                dotWidth: 16.sp,
                radius: 4.sp,
                dotColor: Colors.black26,
                activeDotColor: Colors.black,
                type: WormType.normal,
                strokeWidth: 5.sp,
              ),
            ),
    );
  }
}
