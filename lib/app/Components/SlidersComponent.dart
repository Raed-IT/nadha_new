import 'package:carousel_slider/carousel_slider.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
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
    RxInt activeIndex = RxInt(0);
    final carouselController = CarouselSliderController();
    return Obx(
      () => (isLoad.value)
          ? AspectRatio(
              aspectRatio: 78 / 35,
              child: CardLoadingComponent(
                cardMargin: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(radius ?? 5.sp),
              ),
            )
          : Column(
              children: [
                AspectRatio(
                  aspectRatio: 78 / 35,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: CarouselSlider(
                      carouselController: carouselController,
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
                              child: AspectRatio(
                                aspectRatio: 78 / 35,
                                child: Container(
                                  margin:
                                      margin != null ? EdgeInsets.zero : null,
                                  child: ImageCacheComponent(
                                      fit: BoxFit.cover,
                                      borderRadius:
                                          BorderRadius.circular(radius ?? 5.sp),
                                      height: height,
                                      image: "${e.image}"),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        disableCenter: true,
                        height: height ?? Get.width * 0.6,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: autoPlay,
                        onPageChanged: (index, page) {
                          activeIndex.value = index;
                        },
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
                Obx(
                  () => Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: sliders.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => carouselController.jumpToPage(entry.key),
                          child: Container(
                            width: 10.sp,
                            height: 10.sp,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (AppColors.info).withOpacity(
                                entry.key == activeIndex.value ? 0.9 : 0.2,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

//Curves.linearToEase
// Curves.easeInOutQuint
