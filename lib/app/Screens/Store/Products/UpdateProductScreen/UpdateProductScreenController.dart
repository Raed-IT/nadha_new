import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:dio/dio.dart' as dio;

class UpdateProductScreenController extends GetxController with ApiHelperMixin {
  final ProductModel product = Get.arguments['product'];
  TextEditingController nameController = TextEditingController();
  TextEditingController slugController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController minQtyController = TextEditingController(text: "1");
  RxBool isDiscount = RxBool(false);
  String unitType = "piece";
  String currencyType = "try";
  HLPickerItem? productImage;
  CategoryModel? selectedCategory;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    nameController.text = "${product.name}";
    slugController.text = "${product.slug}";
    priceController.text = "${product.price}";
    infoController.text = "${product.info}";
    discountController.text = "${product.discount ?? ''}";
    minQtyController.text = "${product.minQty}";
    isDiscount.value = product.isDiscount!;
    unitType = product.unit!.name;
    currencyType = product.currency!;
    selectedCategory = Get.find<MainController>()
        .storeCategories
        .firstWhereOrNull((category) => category.id == product.category?.id);
  }

  void updateProduct(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // validation another options

      if (selectedCategory == null) {
        ToastService.showErrorToast(
            context: context, title: "الرجاء القسم الذي ينتمي له المنتج");
        return;
      }
      OverlayLoaderService.show(context);
      dio.MultipartFile? productImg;
      if (productImage != null) {
        productImg = await dio.MultipartFile.fromFile(productImage!.path,
            filename: "${DateTime.now()}");
      }

      dio.FormData data = dio.FormData.fromMap({
        "_method": "PUT",
        if (productImg != null) "image": productImg,
        "slug": slugController.text,
        "store_id": Get.find<MainController>().user.value?.store?.id,
        "name": nameController.text,
        "info": infoController.text,
        "price": priceController.text,
        "min_qty": minQtyController.text,
        "discount":
            "${discountController.text == "null" ? 0 : discountController.text}",
        "is_discount": "${isDiscount.value ? 1 : 0}",
        "unit": unitType,
        "currency": currencyType,
        "category_id": selectedCategory?.id,
      });
      await postData(
          headers: {'Content-Type': 'multipart/form-data'},
          url: "${ApiRoute.products}/${product.id}",
          data: data,
          onSuccess: (res, t) {
            if (res.data['status'] == "SUCCESS") {
              ToastService.showSuccessToast(
                  context: context, title: 'تم تعديل المنتج بنجاح ');
              Get.back(
                  result: ProductModel.fromJson(res.data['data']['product']));
            } else {
              ToastService.showErrorToast(
                  context: context,
                  title: 'خطأ في تعديل المنتج بنجاح ',
                  description: "${res.data['data']['message']}");
            }
          },
          onError: (ex, t) {
            ToastService.showErrorToast(
                context: context, title: 'خطأ في إضافة المنتج بنجاح ');
          });
      OverlayLoaderService.hide();
    } else {
      ToastService.showErrorToast(
          context: context,
          title: "الرجاء التاكن من ملء جميع الحقول بشكل صحيح");
    }
  }
}
