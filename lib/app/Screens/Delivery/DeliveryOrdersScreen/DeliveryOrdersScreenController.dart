import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/OrderModel.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';

class DeliveryOrdersScreenController extends GetxController
    with PaginationMixin<OrderModel>, ApiHelperMixin {
  RxList<OrderModel> orders = RxList([]);

  Future<void> finishedOrder(OrderModel order, BuildContext context) async {
    Get.back();
    OverlayLoaderService.show(context);
    await postData(
        url: "${ApiRoute.orders}/finished/${order.id}",
        data: {},
        onSuccess: (jso, t) {
          ToastService.showSuccessToast(
              context: context, title: "تم انهاء الطلب ");
          orders.remove(order);
        },
        onError: (ex, t) {
          ToastService.showErrorToast(
              context: context, title: "خطاء ${ex.statusCode}");
        });
    OverlayLoaderService.hide();
  }

  @override
  void onInit() {
    super.onInit();
    paginationUrl =
        "${ApiRoute.orders}/${Get.find<MainController>().user.value?.id}";
    getDataFromApi();
  }

  Future getDataFromApi() async {
    await getPaginationData(isRefresh: true);
  }

  Future loadMore() async {
    await getPaginationData(isRefresh: false);
  }

  @override
  List<OrderModel> getModelFromPaginationJsonUsing(Map<String, dynamic> json) {
    for (var order in json['data']['orders']) {
      orders.add(OrderModel.fromJson(order));
    }
    return orders;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']["next_page_url"];
  }
}
