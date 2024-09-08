import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helper_plugin/helper.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/model/cart_item_model.dart';
import 'package:nadha/app/data/model/order_model.dart';
import 'package:dio/dio.dart' as dio;

class OrderDetailsScreenController extends GetxController with ApiHelperMixin {
  OrderModel order = Get.arguments['order'];
  CartItemModel? cartItem;
  bool isStore = false;
  RxBool isPostData = RxBool(false);
  CameraPosition? cameraPosition =
      const CameraPosition(target: LatLng(34.6, -36.4), zoom: 20);

  @override
  void onError(String type) {
    isPostData.value = false;
    EasyLoading.showError("فشلت العملية");
  }

  changeState(CartItemModel model, String status) {
    if (!isPostData.value) {
      EasyLoading.show();
      isPostData.value = true;
      cartItem = model;
      postDataDio(
        url: ApiRouts.bills,
        data: dio.FormData.fromMap({
          "item_id": cartItem?.id,
          "status": status,
        }),
      );
    }
  }

  @override
  void getDataFromPostDioUsing(dynamic json) async {
    EasyLoading.showSuccess("تمت العملية");
    isPostData.value = false;
    int index = order.items!.indexOf(cartItem!);
    if (index != -1) {
      order.items![index].status!.value = "finish";
    }
  }

  List<Marker> markers = [];

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments.containsKey('isStore')) {
      isStore = Get.arguments['isStore'];
    } else {
      isStore = false;
    }
    if (order.address?.longitude != null && order.address?.latitude != null) {
      cameraPosition = CameraPosition(
          target: LatLng(order.address!.latitude!, order.address!.longitude!),
          zoom: 17);
      markers.add(
        Marker(
          position: LatLng(order.address!.latitude!, order.address!.longitude!),
          markerId: MarkerId(""),
        ),
      );
    }
    super.onInit();
  }
}
