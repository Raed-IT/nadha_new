import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/product_model.dart';
import 'package:nadha/app/pages/components/text_field_component.dart';

import '../../../data/model/cart_item_model.dart';
import '../../../them/app_colors.dart';

showAddToCartDialog(
    {required ProductModel product, CartItemModel? cartItem}) async {
  //values for switch between widget
  RxBool showAmount = RxBool(false);
  // showAmount
  // true => order from price
  // false => order from wight

  RxBool isAdd = RxBool(false);
  double? quant;
  if (cartItem != null) {
    quant = cartItem.quantity!.value;
    showAmount.value = cartItem.fromAmount;
  }
  bool isOpenDialog = true;
  await Get.defaultDialog(
    barrierDismissible: false,
    contentPadding: EdgeInsets.zero,
    title: "اختر نوع الطلب",
    content: Padding(
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          Column(
            children: [
              Obx(() => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            disabledColor: AppColors.warning,
                            color: AppColors.scaffold,
                            onPressed: showAmount.value
                                ? () {
                                    showAmount.value = !showAmount.value;
                                  }
                                : null,
                            child: Text(" حسب الوزن"),
                            disabledTextColor: AppColors.scaffold,
                          ),
                          MaterialButton(
                            disabledTextColor: AppColors.scaffold,
                            disabledColor: AppColors.warning,
                            color: AppColors.scaffold,
                            onPressed: !showAmount.value
                                ? () {
                                    showAmount.value = !showAmount.value;
                                  }
                                : null,
                            child: Text("حسب السعر "),
                          )
                        ],
                      ),
                      (showAmount.value)
                          ? BuildTextFieldComponent(
                              label: " السعر",
                              controller: TextEditingController(
                                  text:
                                      (cartItem != null && cartItem.fromAmount)
                                          ? cartItem.price!.toStringAsFixed(1)
                                          : ''),
                              hint: 'اكتب  السعر',
                              onChange: (data) {
                                quant = quant = checkEntry(data);
                              },
                            )
                          : BuildTextFieldComponent(
                              label: "الوزن",
                              controller: TextEditingController(
                                  text:
                                      (cartItem != null && !cartItem.fromAmount)
                                          ? cartItem.quantity!.value
                                              .toStringAsFixed(1)
                                          : ''),
                              hint: 'اكتب الوزن ',
                              onChange: (data) {
                                quant = quant = checkEntry(data);
                              },
                            ),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  // showAmount
                  // true => order from price
                  // false => order from wight
                  if (quant != null) {
                    if (quant! < product.minQty!) {
                      Fluttertoast.showToast(
                          msg: "اصغر كمية للطلب ${product.minQty}");
                    } else {
                      if (cartItem == null) {
                        isAdd.value = true;
                        await Get.find<MainController>().addCartItem(
                          item: showAmount.value
                              ? CartItemModel(RxDouble(0), product, quant!)
                              : CartItemModel(RxDouble(quant!), product, 0),
                          isIncrease: false,
                        );
                        isAdd.value = false;
                      } else {
                        Get.find<MainController>().addCartItem(
                          item: showAmount.value
                              ? CartItemModel(RxDouble(0), product, quant!)
                              : CartItemModel(RxDouble(quant!), product, 0),
                        );
                      }
                      if (isOpenDialog) {
                        Get.back();
                      }
                    }
                  } else {
                    Fluttertoast.showToast(msg: "الرجاء كتابة الكمية");
                  }
                },
                child: Container(
                  width: 110.w,
                  padding:
                      EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                  child: Center(
                    child: Obx(
                      () => (!isAdd.value)
                          ? Text(
                              "اضافة الى السلة",
                              style: TextStyle(
                                  color: AppColors.scaffold, fontSize: 12.sp),
                            )
                          : SizedBox(
                              height: 15.h,
                              width: 15.w,
                              child: CircularProgressIndicator(
                                color: AppColors.scaffold,
                                strokeWidth: 2.sp,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                  child: Text(
                    "الغاء العملية",
                    style:
                        TextStyle(color: AppColors.scaffold, fontSize: 12.sp),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
  isOpenDialog = false;
}

double? checkEntry(String data) {
  double? quant = double.tryParse(data);
  if (quant == null) {
    Fluttertoast.showToast(msg: "الرجاء ادخال قيمة صحيحة");
  }
  return quant;
}
