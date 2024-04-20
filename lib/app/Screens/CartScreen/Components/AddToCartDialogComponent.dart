import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/TextFieldComponent.dart';
import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toastification/toastification.dart';

Future<bool> showAddToCartBottomSheet(
  ProductModel product, {
  required BuildContext context,
  required Function(double qty, GlobalKey kye, ProductUnitTypeEnum unit) onAdd,
  ProductUnitTypeEnum? unit,
  double? qty,
}) async {
  Rxn<ProductUnitTypeEnum> type = Rxn();
  final GlobalKey productKey = GlobalKey();

  ///[status] for get status if don add product to service or not
  bool status = false;

  TextEditingController qtyController =
      TextEditingController(text: qty != null ? qty.toStringAsFixed(1) : '');
  type.value = unit;
  await Get.bottomSheet(
    isScrollControlled: true,
    SizedBox(
      width: Get.width,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 10.sp,
              right: 10.sp),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.verticalSpace,
                BlurryContainer(
                  blur: 7,
                  borderRadius: BorderRadius.circular(10.sp),
                  width: Get.width,
                  child: Row(
                    children: [
                      Container(
                        key: productKey,
                        child: ImageCacheComponent(
                          image: "${product.image}",
                          height: 100.sp,
                          borderRadius: BorderRadius.circular(10.sp),
                          width: 120.sp,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                "${product.name}",
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              10.verticalSpace,
                              AutoSizeText(
                                "${product.info}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ProductUnitTypeEnum.values
                        .where((element) =>
                            element != ProductUnitTypeEnum.piece &&
                            element != ProductUnitTypeEnum.kg)
                        .map(
                          (e) => GestureDetector(
                            onTap: () => type.value = e,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio<ProductUnitTypeEnum>(
                                  value: e,
                                  groupValue: type.value,
                                  onChanged: (va) {
                                    type.value = va;
                                  },
                                ),
                                Text(
                                  e.toProductUnit(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Obx(
                  () => TextFieldComponent(
                    onChange: (data) {
                      if (type.value != null) {
                        if (double.tryParse(data) == null) {
                          Fluttertoast.cancel();
                          Fluttertoast.showToast(msg: "الرجاء كتابة رقم صحيح");
                        }
                      } else {
                        toastification.dismissAll();
                        ToastService.showErrorToast(
                            context: context,
                            title: "الرجاء اختيار كمية / سعر ");
                      }
                    },
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    controller: qtyController,
                    hint: type.value != null
                        ? 'اطلب ${type.value!.toProductUnit()}'
                        : 'حدد الية الطلب',
                  ),
                ),
                20.verticalSpace,
                SizedBox(
                  width: Get.width,
                  child: OutlinedButton(
                    onPressed: () {
                      if (type.value == null) {
                        ToastService.showErrorToast(
                            context: context,
                            title: "الرجاء اختيار كمية / سعر");
                        return;
                      }
                      if (qtyController.text.isEmpty) {
                        ToastService.showErrorToast(
                            context: context,
                            title:
                                "الرجاء كتابة ${type.value!.toProductUnit()}");
                        return;
                      }
                      if (double.tryParse(qtyController.text) == null) {
                        ToastService.showErrorToast(
                            context: context, title: "الرجاء كتابة رقم صحيح");
                        return;
                      }
                      status = true;
                      onAdd(double.parse(qtyController.text), productKey,
                          type.value!);
                      Get.back();
                    },
                    child: const Text("إضافة الى السلة"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
  return status;
}
