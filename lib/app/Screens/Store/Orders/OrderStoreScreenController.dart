import 'package:delevary/app/Data/Models/OrderModel.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';
import 'package:logger/logger.dart';

class OrderStoreScreenController extends GetxController
    with PaginationMixin<OrderModel>, ApiHelperMixin {
  @override
  void onInit() {
    paginationUrl = ApiRoute.storeOrders;
    getFreshData();
    super.onInit();
  }

  loadMore() {
    getPaginationData(isRefresh: false);
  }

  getFreshData() {
    getPaginationData(isRefresh: true);
  }

  receiveOrder(OrderModel order, BuildContext context,
      TextEditingController infoController) async {
    OverlayLoaderService.show(context);
    await postData(
        url: "${ApiRoute.orders}-status",
        data: {"time": infoController.text, "order_id": order.id},
        onSuccess: (res, type) {
          OrderModel orderModel =
              OrderModel.fromJson(res.data['data']['order']);
          int index = paginationData.indexWhere((element) {
            return element.id == orderModel.id;
          });
          Logger().w(index);
          paginationData[index] = orderModel;
          ToastService.showSuccessToast(
              context: context, title: "تم ارسال البيانات");
        },
        onError: (ex, ty) {});
    OverlayLoaderService.hide();
  }

  @override
  List<OrderModel> getModelFromPaginationJsonUsing(Map<String, dynamic> json) {
    List<OrderModel> orders = [];
    for (var order in json['data']['orders']) {
      orders.add(OrderModel.fromJson(order));
    }
    return orders;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']['next_page_url'];
  }
}
