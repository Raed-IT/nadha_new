import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';

class AddressesScreenController extends GetxController with ApiHelperMixin {
  Future<void> deleteAddress(AddressModel address, BuildContext context,
        Function() onSetState) async {
    Get.back();
    OverlayLoaderService.show(context);
    await postData(
        url: "${ApiRoute.addresses}/${address.id}",
        data: {"_method": "DELETE", "address_id": address.id},
        onSuccess: (res, type) {
          Get.find<MainController>().user.value!.addresses!.remove(address);
          ToastService.showSuccessToast(
              context: context, title: 'تم حذف العنوان ${address.name}');
          onSetState();
        },
        onError: (ex, type) {
          ToastService.showErrorToast(
              context: context, title: 'حدث خطاء اثناء الحذف !!');
        });
    Loader.hide();
  }
}
