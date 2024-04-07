import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/Models/BaseModel.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'LoadingComponents/GridListLoading.dart';

class GridListComponent<T extends BaseModel> extends StatelessWidget {
  final List<T> items;
  final RxBool isLoad;
  final ScrollController? scrollController;
  final Function(T item) onTap;

  ///[prifexHero] you can type any prifix and recive it for giv uniq hero tag
  final String? prifexHero;

  const GridListComponent(
      {super.key,
      required this.items,
      required this.isLoad,
      this.scrollController,
      required this.onTap,
      this.prifexHero});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => isLoad.value
          ? const HorizontalListLoading()
          : Container(
              margin: EdgeInsets.only(top: 30.h),
              clipBehavior: Clip.none,
              width: Get.width,
              height: 80.h,
              child: ListView(
                clipBehavior: Clip.none,
                // shrinkWrap: true,
                // physics: const ClampingScrollPhysics(),
                physics: const BouncingScrollPhysics(),
                // itemCount: items.length,
                scrollDirection: Axis.horizontal,
                children: items
                    .map(
                      (item) => buildCard(
                        item,
                        context,
                        (item) => onTap(item),
                      ),
                    )
                    .toList()
                    .animate()
                    .slideX(),
              ),
            ),
    );
  }

  Widget buildCard(T item, BuildContext context, Function(T item) onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: GestureDetector(
        onTap: () => onTap(item),
        child: SizedBox(
          width: 90.w,
          child: Card(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -45.h,
                  right: -5.sp,
                  left: -5.sp,
                  child: Hero(
                    tag: "${prifexHero ?? ''}${item.id}",
                    child: Card(
                      elevation: 3,
                      shadowColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: ImageCacheComponent(
                          borderRadius: BorderRadius.circular(10.sp),
                          height: (Get.width / 3) - 50.w,
                          width: (Get.width / 3) - 20.w,
                          image: "${item.getImage()}"),
                    ),
                  ).animate().slideY(
                        begin: 0.2,
                        duration:
                            Duration(milliseconds: Random().nextInt(400) + 100),
                      ),
                ),
                Positioned(
                  bottom: 2.h,
                  left: 1,
                  right: 1,
                  child: SizedBox(
                    height: 30.h,
                    child: Center(
                      child: AutoSizeText(
                        "${item.getTitle()}  ",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
