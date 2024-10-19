import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:logger/logger.dart';

class AddressListController extends GetxController with ApiHelperMixin {
  Rx<List<AddressModel>> addresses =
      Rx(Get.find<MainController>().user.value?.addresses ?? []);

  Future<void> deleteAddress(
    AddressModel address,
    BuildContext context,
  ) async {
    Get.back();
    OverlayLoaderService.show(context);
    await postData(
        url: "${ApiRoute.addresses}/${address.id}",
        data: {"_method": "DELETE", "address_id": address.id},
        onSuccess: (res, type) {
          Get.find<MainController>().user.value!.addresses!.remove(address);
          addresses.value.remove(address);
           ToastService.showSuccessToast(
              context: context, title: 'تم حذف العنوان ${address.name}');
        },
        onError: (ex, type) {
          ToastService.showErrorToast(
              context: context, title: 'حدث خطاء اثناء الحذف !!');
        });
    Loader.hide();
  }
}
