import 'package:carousel_slider/carousel_slider.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Data/Models/SliderModel.dart';

class SliderComponent extends StatelessWidget {
  final List<SliderModel> sliders;
  final PageController controller;
  final RxBool isLoad;
  final double? height;
  final Function(SliderModel item)? onTapItem;
  final EdgeInsetsGeometry? margin;
  final double? radius;
  final bool autoPlay;

  const SliderComponent(
      {super.key,
      required this.sliders,
      required this.controller,
      required this.isLoad,
      this.margin,
      this.height,
      this.onTapItem,
      this.radius,
      this.autoPlay = false});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (isLoad.value)
          ? Padding(
              padding: EdgeInsets.all(10.sp),
              child: CardLoadingComponent(
                borderRadius: BorderRadius.circular(radius ?? 10.sp),
                height: height ?? 180.h,
              ),
            )
          : Container(
              margin: margin ?? EdgeInsets.symmetric(horizontal: 5.sp),
              child: (sliders.isEmpty)
                  ? Container()
                  : Directionality(
                textDirection: TextDirection.ltr,
                    child: CarouselSlider(
                        items: sliders
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  if (onTapItem != null) {
                                    onTapItem!(e);
                                  }
                                  if (e.url != null) {
                                    launchUrl(Uri.parse("${e.url}"));
                                  }
                                },
                                child: Container(
                                  margin: margin != null ? EdgeInsets.zero : null,
                                  width: Get.width,
                                  child: ImageCacheComponent(
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(
                                          radius ??0),
                                      height: height,
                                      image: "${e.image}"),
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          disableCenter: true,
                          // aspectRatio: 3 / 4,
                          height: Get.width * 0.6,
                          viewportFraction: 1,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: autoPlay,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.8,
                          animateToClosest: false,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                  ),
            ),
    );
  }
}

//Curves.linearToEase
// Curves.easeInOutQuint
