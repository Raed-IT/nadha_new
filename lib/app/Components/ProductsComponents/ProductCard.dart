import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductCardComponent extends StatelessWidget {
  final ProductModel product;
  final Function(GlobalKey kye) onTap;
  final BorderRadius? imageRadius;
  final String? heroTagPrefix;
  final Function(ProductModel product, GlobalKey key) onTapAddProduct;
  final GlobalKey productKey = GlobalKey();

  ProductCardComponent(
      {super.key,
      required this.product,
      required this.onTap,
      this.imageRadius,
      this.heroTagPrefix,
      required this.onTapAddProduct});

  @override
  Widget build(BuildContext context) {
    final GlobalKey productCardKye = GlobalKey();
    return GestureDetector(
      onTap: () => onTap(productCardKye),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        child: BlurryContainer(
          blur: 10,
          borderRadius: BorderRadius.circular(10.sp),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 130.h,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Hero(
                            tag:
                                "${heroTagPrefix ?? 'product_image_'}${product.id}",
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    imageRadius ?? BorderRadius.circular(10.sp),
                              ),
                              child: Container(
                                key: productCardKye,
                                child: ImageCacheComponent(
                                  height: 130.h,
                                  borderRadius: imageRadius ??
                                      BorderRadius.circular(10.sp),
                                  image: "${product.image}",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 30.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10.sp),
                            bottomLeft: Radius.circular(10.sp),
                          ),
                          gradient: const LinearGradient(
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent]),
                        ),
                        child: Center(
                          child: Text(
                            "${product.store?.name}",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          onTapAddProduct(product, productCardKye);
                        },
                        child: SizedBox(
                          height: 35.sp,
                          width: 35.sp,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          width: Get.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  "${product.name} ",
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  "${product.info}",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: BuildPriceProductComponent(
                          product: Rx(product),
                        ),
                      ),
                    ],
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
