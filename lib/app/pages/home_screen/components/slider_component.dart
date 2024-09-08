import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/home_screen/home_controller.dart';
import 'package:nadha/app/them/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/image_cache_component.dart';

class SliderHomeScreenComponent extends GetView<HomeScreenController> {
  const SliderHomeScreenComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 200.h,
        color: AppColors.scaffold,
        child: Obx(
          () => (controller.isLoad.value)
              ? Opacity(
                  opacity: 0.5,
                  child: CardLoading(
                    height: Get.height,
                    width: Get.width,
                  ),
                )
              : (controller.sliders.isNotEmpty)
                  ? CarouselSlider(
                      items: controller.sliders
                          .map(
                            (slider) => GestureDetector(
                              onTap: () async {
                                if (await canLaunchUrl(
                                    Uri.parse("${slider.url}"))) {
                                  launchUrl(Uri.parse("${slider.url}"),
                                      mode: LaunchMode.platformDefault);
                                }
                              },
                              child: ImageCacheComponent(
                                image: "${slider.image}",
                                height: Get.height,
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        aspectRatio: 2.0,
                        initialPage: 0,
                      ),
                    )
                  : Container(),
        ),
      ),
    );
  }
}
