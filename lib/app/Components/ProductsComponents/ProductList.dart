import 'package:delevary/app/Components/ProductsComponents/EmptyProductComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductCard.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductListLoading.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductListComponent extends StatelessWidget {
  final List<ProductModel> products;
  final Function(ProductModel product, GlobalKey key) onProductTap;
  final RxBool isLoad;
  final EdgeInsets? padding;
  final Function(ProductModel product, GlobalKey key) onTapAddProduct;
  final String? heroTagPrefix;
  final Function(ProductModel product)? onRemoveProductFromFavorite;
  final bool? showTitle;
  final String? title;

  const ProductListComponent(
      {super.key,
      required this.onProductTap,
      required this.products,
      required this.isLoad,
      this.padding,
      this.heroTagPrefix,
      required this.onTapAddProduct,
      this.onRemoveProductFromFavorite,
      this.showTitle,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showTitle != null
              ? Padding(
                padding:  EdgeInsets.only(bottom: 24.h),
                child: Text(
                    title ?? '',
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 15.sp),
                  ),
              )
              : const    SizedBox(),
          Obx(
            () => (!isLoad.value)
                ? (products.isNotEmpty)
                    ? GridView.count(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 5/8.4,
                        crossAxisSpacing: 10.sp,
                        mainAxisSpacing: 10.h,
                        children: products
                            .map(
                              (product) => ProductCardComponent(
                                onRemoveProductFromFavorite:
                                    onRemoveProductFromFavorite,
                                heroTagPrefix: heroTagPrefix,
                                product: product,
                                onTap: (kye) => onProductTap(product, kye),
                                onTapAddProduct: (product, kye) {
                                  onTapAddProduct(product, kye);
                                },
                              ),
                            )
                            .toList(),
                      )
                    : const EmptyProductComponent()
                : const ProductLoadingList(),
          ),
        ],
      ),
    );
  }
}
