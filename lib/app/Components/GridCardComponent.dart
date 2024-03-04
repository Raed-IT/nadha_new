import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/Models/BaseModel.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/material.dart';
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
          ? GridListLoading()
          : GridView.count(
              controller: scrollController,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 30.h,
              childAspectRatio: 1 / 1.15,
              children: items
                  .map((item) => buildCard(
                        item,
                        context,
                        (item) => onTap(item),
                      ))
                  .toList(),
            ),
    );
  }

  Widget buildCard(T item, BuildContext context, Function(T item) onTap) {
    return GestureDetector(
      onTap: () => onTap(item),
      child: SizedBox(
        child: Card(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp)),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -30.h,
                right: 5.sp,
                left: 5.sp,
                child: Hero(
                  tag: "${prifexHero ?? ''}${item.id}",
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: ImageCacheComponent(
                        borderRadius: BorderRadius.circular(10.sp),
                        height: (Get.width / 3) - 20.w,
                        width: (Get.width / 3) - 20.w,
                        image: "${item.getImage()}"),
                  ),
                ).animate().slideY(begin: 0.2),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: 50.h,
                  width: (Get.width / 3) - 20.w,
                  child: Padding(
                    padding: EdgeInsets.all(5.sp),
                    child: Center(
                      child: AutoSizeText(
                        "${item.getTitle()}",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
