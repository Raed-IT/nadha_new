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
                  : CarouselSlider(
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
                              child: Card(
                                margin: margin != null ? EdgeInsets.zero : null,
                                child: ImageCacheComponent(
                                    fit: BoxFit.cover,
                                    borderRadius:
                                        BorderRadius.circular(radius ?? 10.sp),
                                    height: height,
                                    image: "${e.image}"),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: Get.width-15.w,
                        viewportFraction: 0.98,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: autoPlay,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
              /*SingleChildScrollView(
                      child: NopSuiteCarouselSlider(
                        height: height ?? 180.h,
                        controller: controller,
                        count: sliders.length,
                        itemBuilder: sliders
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
                                child: Card(
                                  margin:
                                      margin != null ? EdgeInsets.zero : null,
                                  child: ImageCacheComponent(
                                    fit: BoxFit.cover,
                                      borderRadius:
                                          BorderRadius.circular(radius??10.sp),
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
                          paintStyle: PaintingStyle.stroke,
                          strokeWidth: 5.sp,
                        ),
                      ),
                    )*/
              ,
            ),
    );
  }
}
