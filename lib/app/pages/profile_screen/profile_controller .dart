import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/helper.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/user_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nadha/app/services/cart_serveice.dart';
import '../../data/model/city_model.dart';

class ProfileScreenController extends GetxController
    with ImagePickerMixin, ApiHelperMixin {
  UserModel user = Get.find<MainController>().user.value!;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController watsTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  Rxn<CityModel> selectedCity = Rxn();

  @override
  void onInit() {
    int index = Get.find<MainController>()
        .cities
        .indexWhere((p0) => p0.id == user.cityId);
    if (index != -1) {
      selectedCity.value = Get.find<MainController>().cities[index];
    }
    nameTextController.text = user.name ?? '';
    usernameTextController.text = user.username ?? '';
    emailTextController.text = user.email ?? '';
    watsTextController.text = user.whats ?? '';
    super.onInit();
  }

  Future<void> save() async {
    EasyLoading.show();
    Get.find<MainController>().cartItems.value = [];
    Helper.setCartItemToLocaleStorage();
    dio.FormData data = dio.FormData.fromMap(
      {
        "name": nameTextController.text,
        "email": emailTextController.text,
        "username": usernameTextController.text,
        "whats": watsTextController.text,
        if (selectedCity.value != null) "city_id": selectedCity.value!.id,
        if (passwordTextController.text.isNotEmpty)
          "password": passwordTextController.text,
      },
    );
    await postDataDio(url: ApiRouts.profile, data: data);
    EasyLoading.dismiss();
  }

  @override
  void getDataFromPostDioUsing(json) {
    Get.find<MainController>().user.value =
        UserModel.fromJson(json['data']['user']);
    Fluttertoast.showToast(msg: "تم تعديل الملف الشخصي ");
  }
}
