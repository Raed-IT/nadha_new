import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/enums/unit_product_type_enum.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/cart_item_model.dart';
import 'package:nadha/app/data/model/product_model.dart';
import 'package:nadha/app/route/routs.dart';
import 'package:nadha/app/them/app_colors.dart';
import '../../vendor_store_screen/components/update_price_bootomSheet.dart';
import 'add_to_cart_dialog_function.dart';

class ButtonAddProductToCartComponent extends GetView<MainController> {
  final ProductModel product;
  final Function(int index) onDelete;
  final Function()? onRefresh;
  final RxBool isAdd = RxBool(false);
  final Function(ProductModel)? onGetProduct;

  // final RxBool isIncrease = RxBool(false);
  // final RxBool isDecrease = RxBool(false);

  int? get index {
    return Get.find<MainController>()
        .cartItems
        .indexWhere((element) => element.product!.id == product.id);
  }

  ButtonAddProductToCartComponent(
      {super.key,
      required this.product,
      required this.onDelete,
      this.onRefresh,
      this.onGetProduct});

  @override
  Widget build(BuildContext context) {
    if (product.store?.id == Get.find<MainController>().user.value?.id &&
        Get.currentRoute == AppRoutes.VENDOR_STORE_SCREEN) {
      return GestureDetector(
        onTap: () async {
          ProductModel? productModel =
              await showUpdatePriceSheet(product: Rx(product), context: context);
          if (productModel != null && onRefresh != null && onGetProduct!=null) {
            onGetProduct!(productModel);
          }
        },
        child: Container(
          width: Get.width,
          height: 50.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              color: AppColors.warning),
          child: Center(
            child: Text(
              "تعديل السعر ",
              style: TextStyle(color: AppColors.scaffold, fontSize: 13.sp),
            ),
          ),
        ),
      );
    }

    if ((product.isAvailable!)) {
      return Obx(
        () => (index == -1)
            ? GestureDetector(
                onTap: () async {
                  if (product.unit == UnitProductType.piece.name) {
                    isAdd.value = true;
                    await controller.addCartItem(
                      item: CartItemModel(RxDouble(product.qtyNum), product, 0),
                      isIncrease: false,
                    );
                    isAdd.value = false;
                  } else {
                    showAddToCartDialog(
                      product: product,
                    );
                  }
                },
                child: Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                  child: Center(
                    child: (!isAdd.value)
                        ? Text(
                            "اضف الى السلة",
                            style: TextStyle(
                                color: AppColors.scaffold, fontSize: 12.sp),
                          )
                        : SizedBox(
                            height: 15.h,
                            width: 15.w,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: AppColors.scaffold,
                              ),
                            ),
                          ),
                  ),
                ),
              )
            : SizedBox(
                height: 30.h,
                child: Row(
                  children: [
                    Visibility(
                      visible: product.unit == UnitProductType.piece.name,
                      child: Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            await controller.addCartItem(
                              item: CartItemModel(RxDouble(1), product, 0),
                              isIncrease: true,
                            );
                          },
                          child: Container(
                            height: 25.h,
                            width: 22.w,
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.sp),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.plus,
                                size: 10.sp,
                                color: AppColors.scaffold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: GestureDetector(
                        onTap: () {
                          //
                          //
                          //
                          //
                          //
                          //
                          //
                          if (product.unit != UnitProductType.piece.name) {
                            showAddToCartDialog(
                                product: product,
                                cartItem: (index != -1)
                                    ? Get.find<MainController>()
                                        .cartItems[index!]
                                    : null);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.sp),
                          decoration: BoxDecoration(
                            color: AppColors.highlight.withOpacity(0.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.sp),
                            ),
                            border: Border.all(color: AppColors.warning),
                          ),
                          child: Center(
                            child: Obx(
                              () => Text(
                                (controller.cartItems[index!].price! > 0)
                                    ? controller.cartItems[index!].price!
                                        .toStringAsFixed(1)
                                    : controller
                                        .cartItems[index!].quantity!.value
                                        .toStringAsFixed(1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: product.unit == UnitProductType.piece.name,
                      child: Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            controller.decrementQtyProduct(
                              item: controller.cartItems.firstWhere(
                                  (p0) => p0.product!.id == product.id),
                            );
                          },
                          child: Container(
                            height: 25.h,
                            width: 22.w,
                            decoration: BoxDecoration(
                              color: AppColors.danger,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.sp),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.minus,
                                size: 10.sp,
                                color: AppColors.scaffold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );
    } else {
      return Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.all(
            Radius.circular(10.sp),
          ),
        ),
        child: Center(
          child: Text(
            "المنتج غير متوفر",
            style: TextStyle(color: AppColors.scaffold, fontSize: 14.sp),
          ),
        ),
      );
    }
  }
}
