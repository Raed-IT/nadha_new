import 'package:delevary/app/Components/ProductsComponents/ProductCard.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductListLoading.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductListComponent extends StatelessWidget {
  final List<ProductModel> products;
  final Function(ProductModel product) onProductTap;
  final RxBool isLoad;
  final EdgeInsets? padding;

  const ProductListComponent(
      {super.key,
      required this.onProductTap,
      required this.products,
      required this.isLoad,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(10.sp),
      child: Obx(() => (!isLoad.value)
          ? GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.25,
              crossAxisSpacing: 10.sp,
              mainAxisSpacing: 10.h,
              children: products
                  .map(
                    (product) => ProductCardComponent(
                      product: product,
                      onTap: () => onProductTap(product),
                    ),
                  )
                  .toList(),
            )
          : ProductLoadingList()),
    );
  }
}
