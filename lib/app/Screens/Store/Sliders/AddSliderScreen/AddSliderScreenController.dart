import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/SliderModel.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
 import 'package:dio/dio.dart' as dio;

class AddSliderScreenController extends GetxController with ApiHelperMixin {
  PlatformFile? image;
  TextEditingController urlController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  void addSlider(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (image == null) {
        ToastService.showErrorToast(
            context: context, title: "الرجاء اختيار صورة");
        return;
      }
      OverlayLoaderService.show(context);
      dio.MultipartFile productImg;
      productImg = await dio.MultipartFile.fromFile(image!.path!,
          filename: "${DateTime.now()}");
      dio.FormData data = dio.FormData.fromMap({
        "_method": "POST",
        "image": productImg,
        "url": urlController.text,
        "store_id": Get.find<MainController>().user.value?.store?.id,
        "city_id": Get.find<MainController>().user.value?.city?.id,
      });
      await postData(
        headers: {'Content-Type': 'multipart/form-data'},
        url: ApiRoute.sliders,
        data: data,
        onSuccess: (response, String type) {
          Get.back(
              result: SliderModel.fromJson(response.data['data']['slider']));
          ToastService.showSuccessToast(
              context: context, title: "تم إضافة إعلان");
        },
        onError: (ex, String type) {
          ToastService.showErrorToast(
              context: context, title: "خطأ في إضافة إعلان");
        },
      );
      OverlayLoaderService.hide();
    } else {
      ToastService.showErrorToast(
          context: context, title: "الرجاء ملئ جميع الحقول بشكل صحيح");
    }
  }
}
