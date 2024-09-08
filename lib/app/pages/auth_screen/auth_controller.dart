import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helper_plugin/helper.dart';
import 'package:helper_plugin/utilitis/error_type_enum.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/helper.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/city_model.dart';
import 'package:nadha/app/data/model/user_model.dart';
import 'package:nadha/app/route/routs.dart';
import 'package:nadha/app/services/auth_service.dart';
import 'package:nadha/app/them/app_colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreenController extends GetxController with ApiHelperMixin {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  Rxn<CityModel> selectedCity = Rxn();
  String googlePassword = "nadha-password";

  /// login field
  TextEditingController loginUserName = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  /// register field
  TextEditingController registerPassword = TextEditingController();
  TextEditingController registerUserName = TextEditingController();
  TextEditingController registerName = TextEditingController();
  TextEditingController registerEmail = TextEditingController();
  TextEditingController registerWats = TextEditingController();

  Future<void> login() async {
    if (loginKey.currentState!.validate()) {
      EasyLoading.show();
      FormData data = FormData({
        "username": loginUserName.text,
        "password": loginPassword.text,
        "device_token": await Helper.getDeviceNotificationToken(),
      });
      await postGetConnect(url: ApiRouts.login, data: data);
      EasyLoading.dismiss();
    }
  }

  Future<void> getGoogleAccount({bool showCityDialog = false}) async {
    if (showCityDialog) {
      bool isCheckCity = await showCityBottomSheet();
      if (isCheckCity) {
        showLoginGoogleDialog();
      }else{
        Fluttertoast.showToast(msg: "الرجاء اختيار المدينة");
      }
    }else{
      showLoginGoogleDialog();
    }
  }

  void showLoginGoogleDialog() {
    AuthService authService = AuthService();
    authService.signin(onCompleted: (account) {
      if (account != null) {
        loginWithGoogle(account: account);
      } else {
        Fluttertoast.showToast(msg: "يرجى المحاولة مجددا");
      }
    });
  }

  Future<void> loginWithGoogle({required GoogleSignInAccount account}) async {
    EasyLoading.show();

    FormData data = FormData({
      "email": account.email,
      "username": "nadha-${DateTime.now()}",
      "name": account.displayName,
      "whats": "",
      "password": "nadha-password",
      "city_id": selectedCity.value!.id!,
      "device_token": await Helper.getDeviceNotificationToken(),
    });

    await postGetConnect(url: ApiRouts.loginWithGoogle, data: data);
    EasyLoading.dismiss();
  }

  Future<void> register() async {
    if (registerKey.currentState!.validate()) {
      if (selectedCity.value != null) {
        EasyLoading.show();
        FormData data = FormData({
          "email": registerEmail.text,
          "username": registerUserName.text,
          "name": registerName.text,
          "whats": registerWats.text.replaceAll("+", ""),
          "password": registerPassword.text,
          "city_id": selectedCity.value!.id!,
          "device_token": await Helper.getDeviceNotificationToken(),
        });
        await postGetConnect(url: ApiRouts.register, data: data);
        EasyLoading.dismiss();
      } else {
        Fluttertoast.showToast(msg: "الرجاء اختيار المدينة");
      }
    }
  }

  @override
  void getModelFromJsonUsing(json, String urlType) {
    if (urlType == ErrorApiTypeEnum.postGetConnect.name) {
      Helper.saveUserData(
          user: UserModel.fromJson(json['data']['user']),
          token: json['data']['token']);

      // OneSignal.shared
      //     .setExternalUserId("${Get.find<MainController>().user.value?.id}");
      // OneSignal.shared
      //     .setEmail(email: "${Get.find<MainController>().user.value?.email}");
      EasyLoading.showSuccess("تم تسجيل الدخول");
      Get.offAllNamed(AppRoutes.HOME_SCREEN);
    }
  }

  Future<bool> showCityBottomSheet() async {
    bool isCheckCity = false;
    await await Get.bottomSheet(
      Card(
        margin: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 10.sp),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("اختر المدينة :"),
              10.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  color: AppColors.fill,
                ),
                child: Obx(
                  () => DropdownButton<CityModel>(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    focusColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: Get.find<MainController>()
                        .cities
                        .map<DropdownMenuItem<CityModel>>((CityModel city) {
                      return DropdownMenuItem<CityModel>(
                        value: city,
                        child: Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Text(
                            "${city.name}",
                            style: const TextStyle(color: AppColors.dark),
                          ),
                        ),
                      );
                    }).toList(),
                    underline: Container(),
                    icon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.dark.withOpacity(0.5),
                      ),
                    ),
                    isExpanded: true,
                    hint: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: const Text("الرجاء اختيار المدينة"),
                    ),
                    value: selectedCity.value,
                    onChanged: (value) {
                      selectedCity.value = value;
                    },
                  ),
                ),
              ),
              10.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      if (selectedCity.value != null) {
                        isCheckCity = true;
                        Get.back();
                      } else {
                        Fluttertoast.showToast(
                            msg: "الرجاء اختيار مدينة للمتابعة");
                      }
                    },
                    child: Text(
                      "تم",
                      style: TextStyle(
                          color: AppColors.warning,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("الغاء"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      enableDrag: false,
      persistent: true,
      isDismissible: false,
    );
    return isCheckCity;
  }
}
