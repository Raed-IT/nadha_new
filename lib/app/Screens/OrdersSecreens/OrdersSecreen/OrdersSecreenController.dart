import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/OrderModel.dart';
import 'package:delevary/app/data/ApiRoute.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/pagination_mixing.dart';

class OrdersScreenController extends GetxController
    with PaginationMixin<OrderModel> {
  @override
  void onInit() {
    paginationUrl = ApiRoute.orders;
    getFreshData();
    super.onInit();
  }

  Future getFreshData() async {
    getPaginationData(isRefresh: true);
  }

  Future loadMore() async {
    getPaginationData(isRefresh: false);
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
    return json['data']['pagination']["next_page_url"];
  }
}
