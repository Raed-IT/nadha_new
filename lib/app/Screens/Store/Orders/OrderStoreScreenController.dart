import 'package:delevary/app/Data/Models/OrderModel.dart';
import 'package:delevary/app/data/ApiRoute.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/pagination_mixing.dart';
import 'package:logger/logger.dart';

class OrderStoreScreenController extends GetxController
    with PaginationMixin<OrderModel> {
  @override
  void onInit() {
    paginationUrl = "${ApiRoute.storeOrders}";
    getFreshData();
    super.onInit();
  }

  loadMore() {
    getPaginationData(isRefresh: false);
  }

  getFreshData() {
    getPaginationData(isRefresh: true);
  }

  @override
  List<OrderModel> getModelFromPaginationJsonUsing(Map<String, dynamic> json) {
    List<OrderModel> orders = [];
    for (var order in json['data']['orders']) {
      orders.add(OrderModel.fromJson(order));
    }
    Logger().w(orders);
    return orders;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']['next_page_url'];
  }
}
