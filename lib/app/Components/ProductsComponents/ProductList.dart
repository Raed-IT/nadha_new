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

  const ProductListComponent(
      {super.key,
      required this.onProductTap,
      required this.products,
      required this.isLoad,
      this.padding,
      this.heroTagPrefix,
      required this.onTapAddProduct,
      this.onRemoveProductFromFavorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(10.sp),
      child: Obx(
        () => (!isLoad.value)
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
                        onRemoveProductFromFavorite:
                            onRemoveProductFromFavorite,
                        heroTagPrefix: heroTagPrefix,
                        product: product,
                        onTap: (kye) => onProductTap(product, kye),
                        onTapAddProduct: onTapAddProduct,
                      ),
                    )
                    .toList(),
              )
            : const ProductLoadingList(),
      ),
    );
  }
}
