import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nopsuite_carousel_slider/effects/worm_effect.dart';
import 'package:nopsuite_carousel_slider/nopsuite_carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Data/Models/SliderModel.dart';

class SliderComponent extends StatelessWidget {
  final List<SliderModel> sliders;
  final PageController controller;
  final RxBool isLoad;
  final double? height;

  final EdgeInsetsGeometry? margin;

  SliderComponent(
      {super.key,
      required this.sliders,
      required this.controller,
      required this.isLoad,
      this.margin,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (isLoad.value)
          ? CardLoadingComponent(
              height: height,
            )
          : Container(
              margin: margin ?? EdgeInsets.symmetric(horizontal: 5.sp),
              child: (sliders.isEmpty)
                  ? Container()
                  : SingleChildScrollView(
                    child: NopSuiteCarouselSlider(
                        height: height ?? 180.h,
                        controller: controller,
                        count: sliders.length,
                        itemBuilder: sliders
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  if (e.url != null) {
                                    launchUrl(Uri.parse("${e.url}"));
                                  }
                                },
                                child: Card(
                                  margin: margin != null ? EdgeInsets.zero : null,
                                  child: ImageCacheComponent(
                                      borderRadius: BorderRadius.circular(10.sp),
                                      height: height,
                                      image: "${e.image}"),
                                ),
                              ),
                            )
                            .toList(),
                        effect: WormEffect(
                          dotHeight: 4.sp,
                          dotWidth: 16.sp,
                          radius: 4.sp,
                          dotColor: Theme.of(context).colorScheme.onBackground,
                          activeDotColor: Theme.of(context).colorScheme.primary,
                          type: WormType.normal,
                          strokeWidth: 5.sp,
                        ),
                      ),
                  ),
            ),
    );
  }
}
