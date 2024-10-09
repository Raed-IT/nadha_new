import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/StoresScreens/StoresScreen/StoresScreenController.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/cupertino.dart';
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
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                  crossAxisSpacing: 0.sp,
                  mainAxisSpacing: 10.h,
                  children: stores
                      .map(
                        (store) => buildStoreCard(store),
                      )
                      .toList(),
                ),
    );
  }

  Widget buildStoreCard(StoreModel store) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(AppRoutes.showStore, arguments: {"store": store}),
      child: SizedBox(
        height: 200.h,
        width: 150.w,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          elevation: 5,
          shadowColor: Colors.black12,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: Column(
              children: [
                ImageCacheComponent(
                  borderRadius: BorderRadius.circular(10.sp),
                  image: "${store.image}",
                  height: 135.h,
                  width: 135.h,
                ),
                8.verticalSpace,
                Text(
                  "${store.name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 13.sp),
                ),
                8.verticalSpace,
                Text(
                  "${store.info}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 12.sp, color: AppColors.highLightColor),
                ),
              ],
            ),
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
