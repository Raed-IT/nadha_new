import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/home_screen/home_controller.dart';
import 'package:nadha/app/them/app_colors.dart';

import '../../components/image_cache_component.dart';

class CategoriesHomeScreenComponents extends GetView<HomeScreenController> {
  const CategoriesHomeScreenComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        color: AppColors.scaffold,
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              height: 50.h,
              child: (controller.isLoad.value)
                  ? ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Opacity(
                          opacity: 0.5,
                          child: CardLoading(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.sp),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            height: 35.h,
                            width: double.parse(
                                    (Random().nextInt(100) + 50).toString())
                                .w,
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        int duration = 300 + (index * 110);
                        if (duration > 2000) {
                          duration = 2000;
                        }
                        return GestureDetector(
                          onTap: () {
                            if (controller.selectedCategory.value != null) {
                              if (controller.selectedCategory.value!.id ==
                                  controller.categories[index].id) {
                                controller.selectedCategory.value = null;
                                return;
                              }
                            }
                            controller.selectedCategory.value =
                                controller.categories[index];
                          },
                          child: Obx(() => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                        color: (controller.selectedCategory
                                                    .value?.id ==
                                                controller.categories[index].id)
                                            ? AppColors.warning
                                            : AppColors.highlight,
                                        borderRadius:
                                            BorderRadius.circular(5.sp)),
                                    height: 35.h,
                                    constraints: BoxConstraints(minWidth: 50.w),
                                    margin: EdgeInsets.all(6.sp),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5000.sp),
                                          ),
                                          child: ImageCacheComponent(
                                              width: 30.w,
                                              height: 30.h,
                                              image:
                                                  "${controller.categories[index].image}"),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          "${controller.categories[index].name}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: (controller
                                                          .selectedCategory
                                                          .value
                                                          ?.id ==
                                                      controller
                                                          .categories[index].id)
                                                  ? AppColors.scaffold
                                                  : AppColors.dark,
                                              fontSize: 15.sp),
                                        ),
                                      ],
                                    ),
                                  )).animate().slideX(
                                duration: Duration(
                                  milliseconds: duration,
                                ),
                              ),
                        );
                      }),
            ),
            Divider(
              thickness: 2.sp,
              indent: 10.w,
              endIndent: 10.w,
            ),
          ],
        ),
      ),
    );
  }
}
