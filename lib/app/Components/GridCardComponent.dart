import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/Models/BaseModel.dart';
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

  const GridListComponent(
      {super.key,
      required this.items,
      required this.isLoad,
      this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => isLoad.value
          ? Container()
          : GridView.count(
              controller: scrollController,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 30.h,
              childAspectRatio: 1 / 1.15,
              children: items.map((item) => buildCard(item, context)).toList(),
            ),
    );
  }

  Widget buildCard(T item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Logger().e(item.getImage());
      },
      child: SizedBox(
        child: Card(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -30.h,
                right: 5.sp,
                left: 5.sp,
                child: Card(
                  child: ImageCacheComponent(
                      height: (Get.width / 3) - 20.w,
                      width: (Get.width / 3) - 20.w,
                      image: "${item.getImage()}"),
                ).animate().slideY(begin: 0.2),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: (Get.width / 3) - 20.w,
                  child: Padding(
                    padding: EdgeInsets.all(5.sp),
                    child: AutoSizeText(
                      "${item.getTitle()} a;sdkl askld slkfj dskljfl dks jaklsj ",
                      maxLines: 2,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold),
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
