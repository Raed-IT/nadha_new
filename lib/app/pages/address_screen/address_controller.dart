import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/helper.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/address_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nadha/app/route/routs.dart';
import 'package:nadha/app/services/location_service.dart';

import '../components/show_info_order_bottomsheet.dart';

class AddressScreenController extends GetxController
    with PaginationMixin<AddressModel>, ApiHelperMixin {
  bool isAddOrder = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  Rxn<LocationData> location = Rxn();

  restInput() {
    nameTextController.clear();
    addressTextController.clear();
  }

  getLocation() async {
    EasyLoading.show();
    LocationService locationService = LocationService();
    location.value = await locationService.getLocation();
    EasyLoading.dismiss();
  }

  deleteAddress({required AddressModel address}) async {
    EasyLoading.show();
    await deleteGetConnect(url: ApiRouts.addresses, id: address.id!);
    EasyLoading.dismiss();
    getPaginationData(isRefresh: true);
  }

  @override
  void onInit() {
    url = ApiRouts.addresses;
    if (Get.find<MainController>().addresses.isEmpty) {
      getPaginationData(isRefresh: true);
    } else {
      paginationData.value = Get.find<MainController>().addresses;
    }
    super.onInit();
  }

  Future<void> saveOrder({required BuildContext context}) async {
    String info = await showIfonBootomSheet(context: context);

    isAddOrder = true;
    final items = Get.find<MainController>().cartItems;
    dio.FormData data = dio.FormData.fromMap({});
    data.fields.add(MapEntry("address_id",
        "${Get.find<MainController>().selectedAddress.value!.id}"));

    data.fields.add(MapEntry("info", info));

    for (int i = 0; i < items.length; i++) {
      data.fields
          .add(MapEntry("items[$i][product_id]", "${items[i].product!.id!}"));
      if (items[i].price! > 0) {
        data.fields.add(MapEntry("items[$i][price]", "${items[i].price}"));
      } else {
        data.fields
            .add(MapEntry("items[$i][quantity]", "${items[i].quantity}"));
      }
    }

    // تفاخ وزن 2
    // لحمة سعر 100
    //
    EasyLoading.show();
    await postDataDio(url: ApiRouts.orders, data: data);
    EasyLoading.dismiss();
    isAddOrder = false;
  }

  @override
  void onError(String type) {
    EasyLoading.showError("حصل خطاء ما ");
  }

  @override
  void getDataFromPostDioUsing(dynamic json) async {
    if (isAddOrder) {
      Get.find<MainController>().cartItems.clear();
      await Helper.setCartItemToLocaleStorage();
      Get.find<MainController>().selectedAddress.value = null;
      EasyLoading.showSuccess("تم ارسال طلبك بنجاح ");
      Get.offAndToNamed(AppRoutes.ORDERS_SCREEN);
    }
  }

  addAddress() async {
    isAddOrder = false;
    if (formKey.currentState!.validate()) {
      Get.back();
      EasyLoading.show();
      dio.FormData data = dio.FormData.fromMap({
        "name": nameTextController.text,
        "address": addressTextController.text,
      });
      if (location.value != null) {
        data.fields.add(
          MapEntry("latitude", "${location.value!.latitude}"),
        );
        data.fields.add(
          MapEntry("longitude", "${location.value!.longitude}"),
        );
      }
      await postDataDio(url: ApiRouts.addresses, data: data);
      getPaginationData(isRefresh: true);
      EasyLoading.showSuccess("تم إضافة العنوان");
      restInput();
    }
  }

  @override
  List<AddressModel> getModelFromPaginationJsonUsing(
      Map<String, dynamic> json) {
    List<AddressModel> addresses = [];
    for (var address in json['data']['address']) {
      addresses.add(AddressModel.fromJson(address));
    }
    Get.find<MainController>().addresses = addresses;
    return addresses;
  }
}
