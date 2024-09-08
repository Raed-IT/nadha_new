import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/product_model.dart';
import 'package:nadha/app/pages/components/text_field_component.dart';
import 'package:nadha/app/them/app_colors.dart';
import 'package:dio/dio.dart' as dio;

Future<ProductModel?> showUpdatePriceSheet(
    {required Rx<ProductModel> product, required BuildContext context}) async {
  bool isUpdate = false;
  ProductModel? productModel;
  RxBool discountStatus = RxBool(product.value.isDiscount!);
  RxBool availableStatus = RxBool(product.value.isAvailable!);
  TextEditingController priceController =
      TextEditingController(text: "${product.value.price}");
  TextEditingController newPriceController =
      TextEditingController(text: "${product.value.price}");
  TextEditingController discountPriceController =
      TextEditingController(text: "${product.value.discount}");
  await showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(15.sp),
        topLeft: Radius.circular(15.sp),
      ),
    ),
    isScrollControlled: true,
    enableDrag: true,
    context: context,
    builder: (context) => Obx(() => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 10.sp,
              right: 10.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.verticalSpace,
              Text(
                "تعديل سعر المنتج ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  color: AppColors.dark,
                ),
              ),
              Text(
                "${product.value.name}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.info,
                ),
              ),
              BuildTextFieldComponent(
                  isDisable: false,
                  controller: priceController,
                  hint: 'سعر المنتج',
                  label: "السعر  القديم"),
              15.verticalSpace,
              BuildTextFieldComponent(
                onChange: (data) {
                  if (double.tryParse(data) == null) {
                    Fluttertoast.showToast(msg: "الرجاء كتابة رقم صالح");
                    newPriceController.clear();
                  }
                },
                controller: newPriceController,
                hint: 'اكتب سعر المنتج الجديد',
                label: "السعر  الجديد ",
              ),
              10.verticalSpace,
              Obx(() => Row(
                    children: [
                      Text("تفعيل العرض :"),
                      Switch(
                        value: discountStatus.value,
                        onChanged: (val) => discountStatus.value = val,
                        activeColor: AppColors.warning,
                      ),
                      Spacer(),
                      Text("توفر المنتج:"),
                      Switch(
                        value: availableStatus.value,
                        onChanged: (val) => availableStatus.value = val,
                        activeColor: AppColors.warning,
                      ),
                    ],
                  )),
              Obx(
                () => discountStatus.value
                    ? BuildTextFieldComponent(
                        onChange: (data) {
                          if (double.tryParse(data) == null) {
                            Fluttertoast.showToast(
                                msg: "الرجاء كتابة رقم صالح");
                            discountPriceController.clear();
                          }
                        },
                        controller: discountPriceController,
                        hint: 'اكتب سعر المنتج بعد الحسم',
                        label: "السعر  بعد الحسم ",
                      )
                    : Container(),
              ),
              10.verticalSpace,
              MaterialButton(
                height: 50.h,
                minWidth: Get.width,
                onPressed: () async {
                  if (newPriceController.text.isNotEmpty && !isUpdate) {
                    if (discountStatus.value &&
                        discountPriceController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "الرجاء اما تعبئة حقل الخصم او الغاء الخصم ");
                      return;
                    }
                    isUpdate = true;
                    productModel = await updatePrice(
                        productId: product.value.id!,
                        data: dio.FormData.fromMap({
                          "_method": "PUT",
                          "price": newPriceController.text,
                          "is_discount": discountStatus.value == true ? 1 : 0,
                          "discount": discountPriceController.text,
                          "is_available": availableStatus.value == true ? 1 : 0,
                        }));
                    isUpdate = false;
                    if (productModel != null) {
                      product.value = productModel!;
                    }
                    EasyLoading.dismiss();
                  } else {
                    Fluttertoast.showToast(
                        msg: "الرجاء كتابة سعر المنتج الجديد");
                  }
                },
                color: AppColors.highlight,
                child: const Text("حفظ"),
              )
            ],
          ),
        )),
  );
  return productModel;
}

/*
price
is_discount
discount
is_available
* */
Future<ProductModel?> updatePrice(
    {required int productId, required dio.FormData data}) async {
  dio.Dio dioReq = dio.Dio();
  dioReq.options.headers["Content-Type"] = "application/json";
  dioReq.options.headers["authorization"] =
      "Bearer ${Get.find<MainController>().token}";
  try {
    EasyLoading.show();
    dio.Response response =
        await dioReq.post("${ApiRouts.products}/$productId", data: data);
    if (response.statusCode == 200 && response.data['status'] == "Success") {
      Get.back();
      ProductModel product =
          ProductModel.fromJson(response.data['data']['product']);
      return product;
    }
    EasyLoading.dismiss();
  } on dio.DioError catch (e) {
    EasyLoading.dismiss();
    if (e.response?.statusCode == 404) {
      Fluttertoast.showToast(
        msg: "الطلب غير موجود ",
      );
    } else if (e.response?.statusCode == 500) {
      Fluttertoast.showToast(msg: "خطأ السيرفر  ");
    } else {
      Fluttertoast.showToast(msg: "${e.message}");
    }
  }
  return null;
}
