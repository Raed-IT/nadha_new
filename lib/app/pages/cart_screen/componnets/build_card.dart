import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/cart_item_model.dart';
import 'package:nadha/app/data/model/product_model.dart';
import 'package:nadha/app/pages/cart_screen/cart_controller.dart';

import '../../../them/app_colors.dart';
import '../../components/add_to_cart/add_product_button_component.dart';
import '../../components/image_cache_component.dart';

class BuildCardCartItemComponent extends GetView<CartScreenController> {
  final CartItemModel cartItem;
  final Animation<double> animation;
  final int index;
  final Function(ProductModel product) ? onGetProduct;

  BuildCardCartItemComponent(
      {required this.cartItem,
      required this.animation,
      required this.index,
      this.onGetProduct,
      super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isDelete = RxBool(false);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ),
        ),
        child: SizedBox(
          height: 120.h,
          width: Get.width,
          child: Card(
            elevation: 7,
            shadowColor: AppColors.highlight.withOpacity(0.5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                      child: ImageCacheComponent(
                        height: Get.height,
                        width: 100.w,
                        image: "${cartItem.product?.img}",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                maxLines: 1,
                                cartItem.product?.name ?? '',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                    "${cartItem.product!.isDiscount! ? cartItem.product?.discount : cartItem.product?.price}")),
                            GestureDetector(
                              onTap: () async {
                                isDelete.value = true;
                                bool status = await controller.deleteProduct(
                                    cartItem: cartItem);
                                isDelete.value = false;
                              },
                              child: Container(
                                padding: EdgeInsets.all(7.sp),
                                decoration: BoxDecoration(
                                  color: AppColors.danger,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.sp),
                                  ),
                                ),
                                child: Obx(
                                  () => Center(
                                    child: (!isDelete.value)
                                        ? SvgPicture.asset(
                                            "assets/svg/delete.svg")
                                        : SizedBox(
                                            width: 13.w,
                                            height: 13.h,
                                            child: CircularProgressIndicator(
                                              color: AppColors.scaffold,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 140.w,
                              height: 25.h,
                              child: ButtonAddProductToCartComponent(
                                onGetProduct: onGetProduct,
                                product: cartItem.product!,
                                onDelete: (int index) {
                                  controller.deleteCartItemFromList(
                                    cartItem: cartItem,
                                    index: Get.find<MainController>()
                                        .cartItems
                                        .indexWhere(
                                          (p0) =>
                                              p0.product!.id ==
                                              cartItem.product!.id,
                                        ),
                                  );
                                },
                              ),
                            ),
                            Text(
                              cartItem.localTotalPrice.toStringAsFixed(1),
                              style: const TextStyle(color: AppColors.danger),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
