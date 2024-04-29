import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Screens/Store/Products/ProductsScreen/ProductsScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'BuildStoreProductCard.dart';

class BuildProductsListStoreComponent
    extends GetView<StoreProductsScreenController> {
  final Future<bool>Function(ProductModel product, bool status) onChangeStatus;

  const BuildProductsListStoreComponent(  {super.key,required this.onChangeStatus});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.isLoadPaginationData.value)
          ? Column(
              children: List.generate(10, (index) => index)
                  .map(
                    (e) => CardLoadingComponent(
                      borderRadius: BorderRadius.circular(10.sp),
                      width: Get.width,
                      height: 150.h,
                    ),
                  )
                  .toList(),
            )
          : (controller.paginationData.isEmpty)
              ? GestureDetector(
                  onTap: () => controller.getDataFromApi(),
                  child: SizedBox(
                    height: 500.h,
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/json/empty_cube.json",
                            height: 250.h),
                        Text(
                          "لايوجد منتجات انقر للتحديث",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.sp),
                        )
                      ],
                    ),
                  ),
                )
              : Column(
                  children: controller.paginationData
                      .map((product) => BuildStoreProductCardComponent(
                            product: product,
                            onChangeStatus: onChangeStatus,
                          ))
                      .toList(),
                ),
    );
  }
}
