import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';
import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import '../../Services/UI/ToastService.dart';

class ProfileScreenController extends GetxController with ApiHelperMixin {
  RxList<bool> selectedButton = RxList([true, false]);
  RxInt selectedIndex = RxInt(0);

  // user
  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController bioTextController = TextEditingController();
  CityModel? city;
  CityModel? storeCity;

  //
  TextEditingController storeNameTextController = TextEditingController();
  TextEditingController storeAddressTextController = TextEditingController();
  TextEditingController storeInfoTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    //user
    UserModel user = Get.find<MainController>().user.value!;
    nameTextController.text = "${user.name}";
    phoneTextController.text = user.phone ?? '';
    bioTextController.text = user.bio ?? '';
    city = user.city;
    //store
    storeCity = user.store?.city;
    storeNameTextController.text = user.store?.name ?? '';
    storeAddressTextController.text = user.store?.address ?? '';
    storeInfoTextController.text = user.store?.info ?? '';
  }

  void onSelectedButton(int index) {
    selectedIndex.value = index;
    selectedButton.value = [false, false];
    selectedButton[index] = true;
  }

  Future updateStoreProfiled(BuildContext context) async {
    if (storeCity == null) {
      ToastService.showErrorToast(
          context: context, title: 'الرجاء اختيار مدينة لمتجرك');
      return;
    }
    OverlayLoaderService.show(context);
    await postData(
        url:
            "${ApiRoute.stores}/${Get.find<MainController>().user.value?.store?.id}",
        data: {
          "_method": "PUT",
          "name": storeNameTextController.text,
          "address": storeAddressTextController.text,
          "info": storeInfoTextController.text,
          "city_id": storeCity?.id,
        },
        onSuccess: (res, t) {
          if (res.data['status'] == "SUCCESS") {
            ToastService.showSuccessToast(
                context: context, title: 'تم تعديل بيانات المتجر ');
            Get.find<MainController>().user.value =
                UserModel.fromJson(res.data['data']['user']);
            Get.offNamed(AppRoutes.mainScaffoldScreen);
          } else {
            ToastService.showErrorToast(
                context: context,
                title: 'خطأ في تعديل بيانات المتجر ',
                description: "${res.data['data']['message']}");
          }
        },
        onError: (ex, t) {
          ToastService.showErrorToast(
              context: context, title: 'خطأ في تعديل بيانات المتجر ');
        });
    OverlayLoaderService.hide();
  }

  Future updateUserProfiled(BuildContext context) async {
    if (city == null) {
      ToastService.showErrorToast(
          context: context, title: 'الرجاء اختيار مدينتك');
      return;
    }
    OverlayLoaderService.show(context);
    await postData(
        url: "${ApiRoute.users}/${Get.find<MainController>().user.value!.id}",
        data: {
          "_method": "PUT",
          "name": nameTextController.text,
          "phone": phoneTextController.text,
          "city_id": city?.id,
          "bio": bioTextController.text,
        },
        onSuccess: (res, t) {
          if (res.data['status'] == "SUCCESS") {
            ToastService.showSuccessToast(
                context: context, title: 'تم تعديل بيانات المستخدم ');
            Get.find<MainController>().user.value =
                UserModel.fromJson(res.data['data']['user']);
            Get.offNamed(AppRoutes.mainScaffoldScreen);
          } else {
            ToastService.showErrorToast(
                context: context,
                title: 'خطأ في تعديل بيانات المستخدم ',
                description: res.data['data']['message']);
          }
        },
        onError: (ex, t) {
          ToastService.showErrorToast(
              context: context, title: 'خطأ في تعديل بيانات المستخدم ');
        });
    OverlayLoaderService.hide();
  }
}
