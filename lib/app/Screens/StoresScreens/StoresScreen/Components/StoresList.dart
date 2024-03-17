import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/StoresScreens/StoresScreen/StoresScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class StoresListComponent extends GetView<StoresScreenController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: (!controller.isLoadPaginationData.value)
            ? (controller.paginationData.isNotEmpty)
                ? controller.paginationData
                    .map((store) => buildStoreCard(store, context))
                    .toList()
                : [noStoresWidget(context)]
            : List.generate(20, (index) => index)
                .map(
                  (e) => CardLoadingComponent(
                    height: 100.h,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget buildStoreCard(StoreModel store, BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.showStore, arguments: {"store": store}),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(color: Theme.of(context).colorScheme.primary)),
        child: BlurryContainer(
          blur: 10,
          borderRadius: BorderRadius.circular(10.sp),
          child: Row(
            children: [
              ImageCacheComponent(
                image: "${store.image}",
                width: 100.sp,
                height: 100.sp,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "${store.name}",
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      10.verticalSpace,
                      AutoSizeText(
                        "${store.info}",
                        maxLines: 1,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noStoresWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.getFreshData(),
      child: Column(
        children: [
          Lottie.asset(
            "assets/json/stores.json",
            width: 300.w,
            height: 300.h,
          ),
          Transform.translate(
            offset: Offset(0, -80.h),
            child: Text(
              'لايوجد متاجر اضغط للتحديث',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
