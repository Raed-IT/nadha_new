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

class StoresListComponent extends StatelessWidget {
  final List<StoreModel> stores;
  final RxBool isLoad;
  final Function? getFreshData;

  const StoresListComponent(
      {super.key,
      required this.stores,
      required this.isLoad,
      this.getFreshData});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (isLoad.value)
          ? Column(
              children: List.generate(20, (index) => index)
                  .map(
                    (e) => CardLoadingComponent(
                      height: 100.h,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  )
                  .toList(),
            )
          : (stores.isEmpty)
              ? noStoresWidget(context, getFreshData)
              : GridView.count(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.2,
                  crossAxisSpacing: 0.sp,
                  mainAxisSpacing: 10.h,
                  children: stores
                      .map((store) => buildStoreCard(store, context))
                      .toList(),
                ),
    );
    // return Obx(
    //   () => Column(
    //     children: (!isLoad.value)
    //         ? (stores.isNotEmpty)
    //             ? stores.map((store) => buildStoreCard(store, context)).toList()
    //             : [noStoresWidget(context, getFreshData)]
    //         : List.generate(20, (index) => index)
    //             .map(
    //               (e) => CardLoadingComponent(
    //                 height: 100.h,
    //                 borderRadius: BorderRadius.circular(10.sp),
    //               ),
    //             )
    //             .toList(),
    //   ),
    // );
  }

  Widget buildStoreCard(StoreModel store, BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(AppRoutes.showStore, arguments: {"store": store}),
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(color: Theme.of(context).colorScheme.primary)),
        child: BlurryContainer(
          blur: 10,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(10.sp),
          child: Column(
            children: [
              ImageCacheComponent(
                fit: BoxFit.cover,
                image: "${store.image}",
                width: Get.width,
                height: 130.sp,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                          "${store.name}",
                          maxLines: 2,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      Align(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                          "${store.info}",
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            overflow: TextOverflow.ellipsis,
                          ),
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

  Widget noStoresWidget(BuildContext context, Function? getFreshData) {
    return GestureDetector(
      onTap: () => getFreshData?.call(),
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
