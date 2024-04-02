import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';
import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenController.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helper/helper.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:logger/logger.dart';
import '../../Services/UI/ToastService.dart';
import 'package:dio/dio.dart' as dio;

class ProfileScreenController extends GetxController with ApiHelperMixin {
  RxList<bool> selectedButton = RxList([true, false]);
  RxInt selectedIndex = RxInt(0);
  HLPickerItem? storeImage;
  HLPickerItem? userImage;

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
    dio.MultipartFile? storeImg;
    if (storeImage != null) {
      storeImg = await dio.MultipartFile.fromFile(storeImage!.path,
          filename: "${DateTime.now()}");
    }
    dio.FormData data = dio.FormData.fromMap({
      "_method": "PUT",
      "name": storeNameTextController.text,
      "address": storeAddressTextController.text,
      "info": storeInfoTextController.text,
      "city_id": storeCity?.id,
      if (storeImg != null) "image": storeImg,
    });
    await postData(
        headers: {'Content-Type': 'multipart/form-data'},
        url:
            "${ApiRoute.stores}/${Get.find<MainController>().user.value?.store?.id}",
        data: data,
        onSuccess: (res, t) {
          if (res.data['status'] == "SUCCESS") {
            ToastService.showSuccessToast(
                context: context, title: 'تم تعديل بيانات المتجر ');
            Get.find<MainController>().user.value =
                UserModel.fromJson(res.data['data']['user']);
            Get.find<MainScaffoldScreenController>().activePage.value = 0;
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
    dio.MultipartFile? userImg;

    if (userImage != null) {
      userImg = await dio.MultipartFile.fromFile(userImage!.path,
          filename: "${DateTime.now()}");
    }
    dio.FormData data = dio.FormData.fromMap({
      "_method": "PUT",
      "name": nameTextController.text,
      "phone": phoneTextController.text,
      "city_id": city?.id,
      "bio": bioTextController.text,
      if (userImg != null) "image": userImg,
    });
    await postData(
        headers: {'Content-Type': 'multipart/form-data'},
        url: "${ApiRoute.users}/${Get.find<MainController>().user.value!.id}",
        data: data,
        onSuccess: (res, t) {
          if (res.data['status'] == "SUCCESS") {
            ToastService.showSuccessToast(
                context: context, title: 'تم تعديل بيانات المستخدم ');
            Get.find<MainController>().user.value =
                UserModel.fromJson(res.data['data']['user']);
            Get.find<MainScaffoldScreenController>().activePage.value = 0;
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
