import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> showProductDetailsBottomSheet(
    {required Rx<ProductModel> product,
    required BuildContext context,
    required Widget productList}) async {
  await Get.bottomSheet(
    DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.8,
      minChildSize: 0.6,
      shouldCloseOnMinExtent: false,
      snapAnimationDuration: 700.ms,
      builder: (context, scrollController) => SizedBox(
        width: Get.width,
        child: Card(
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.value.name}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                    softWrap: true,
                  ),
                  Text(
                    "${product.value.info}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    softWrap: true,
                  ),
                  Row(
                    children: [
                      BuildPriceProductComponent(
                        size: 18.sp,
                        product: product,
                      ),
                    ],
                  ),
                  productList
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    enableDrag: true,
  );
  Get.back();
}
