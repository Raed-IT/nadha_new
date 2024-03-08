import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:add_to_cart_animation/badge_options.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Screens/ShowProductScreen/Components/AddToCartComponent.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../Components/TitleSectionComponent.dart';
import '../../../Data/MainController.dart';

class ShowProductBottomSheet extends StatefulWidget {
  final Widget productList;
  final ShowProductScreenController controller;
  final Function(ProductModel product)? onAddProduct;
  final GlobalKey<CartIconKey> cartKey;

  const ShowProductBottomSheet({
    super.key,
    required this.productList,
    this.onAddProduct,
    required this.controller,
    required this.cartKey,
  });

  @override
  State<ShowProductBottomSheet> createState() => _ShowProductBottomSheetState();
}

class _ShowProductBottomSheetState extends State<ShowProductBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
                          product: widget.controller.product.value,
                          onAddProduct: widget.onAddProduct,
                          onSetState: () {
                            if (widget.cartKey.currentState != null) {
                              widget.cartKey.currentState!.runCartAnimation(
                                  "${Get.find<MainController>().cart.length}");
                            }
                            setState(() {});
                          },
                        ),
                        const Spacer(),
                        Obx(
                          () => Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(500.sp),
                            ),
                            child: SizedBox(
                              height: 60.sp,
                              width: 60.sp,
                              child: AddToCartIcon(
                                key: widget.cartKey,
                                icon: Center(
                                  child: SvgPicture.asset(
                                    "assets/svg/cart.svg",
                                    width: 30.w,
                                  ),
                                ),
                                badgeOptions: BadgeOptions(
                                  active: Get.find<MainController>()
                                      .cart
                                      .isNotEmpty,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),
                        ),
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
                                "${widget.controller.product.value.name}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                                softWrap: true,
                              ),
                              Text(
                                "${widget.controller.product.value.info}",
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
                                product: widget.controller.product,
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
                    widget.productList
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
