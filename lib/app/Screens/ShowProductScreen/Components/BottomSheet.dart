import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Screens/ShowProductScreen/Components/AddToCartComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Components/TitleSectionComponent.dart';

class ShowProductBottomSheet extends StatelessWidget {
  final Rx<ProductModel> product;
  final Widget productList;
  final GlobalKey productKey;
  final Function(ProductModel product)? onAddProduct;

  const ShowProductBottomSheet(
      {super.key,
      required this.product,
      required this.productList,
      required this.productKey, this.onAddProduct});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      initialChildSize: 0.6,
      maxChildSize: 0.95,
      minChildSize: 0.6,
      shouldCloseOnMinExtent: false,
      snapAnimationDuration: 700.ms,
      builder: (context, scrollController) => SizedBox(
        width: Get.width,
        child: Card(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.1,
                repeat: ImageRepeat.repeat,
                image: AssetImage('assets/images/bg.png'),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    Row(
                      children: [
                        10.horizontalSpace,
                        AddToCardComponent(
                          product: product.value,
                          onAddProduct: onAddProduct,
                        ),
                        const Spacer(),
                        Obx(() => SizedBox(
                              height: 60.sp,
                              width: 60.sp,
                              child: Hero(
                                tag: "cart",
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.sp)),
                                  child: AddToCartIcon(
                                    key: Get.find<MainController>().cartKey,
                                    icon: const Icon(Icons.shopping_cart),
                                    badgeOptions: BadgeOptions(
                                      active: Get.find<MainController>()
                                          .cart
                                          .isNotEmpty,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        10.horizontalSpace,
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10.sp),
                      child: BlurryContainer(
                        blur: 7,
                        borderRadius: BorderRadius.circular(10.sp),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10.sp),
                          child: Column(
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                softWrap: true,
                              ),
                              20.verticalSpace,
                              BuildPriceProductComponent(
                                size: 18.sp,
                                product: product,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    40.verticalSpace,
                    BuildTitleSectionComponent(
                      isLoad: RxBool(false),
                      title: "منتجات ذات صلة",
                    ),
                    20.verticalSpace,
                    productList
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
