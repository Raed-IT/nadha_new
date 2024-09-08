import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/order_model.dart';

class DriverOrderDetailsScreenController extends GetxController
    with PaginationMixin<OrderModel> {
  @override
  void onInit() {
    url = ApiRouts.ordersDriver;
    getPaginationData(isRefresh: true);
    super.onInit();
  }

  bool get isShowUpdateOrderButtonPermission {
    return Get.find<MainController>().user.value?.level == "admin" ||
        Get.find<MainController>().user.value?.level == "driver";
  }

  @override
  List<OrderModel> getModelFromPaginationJsonUsing(Map<String, dynamic> json) {
    List<OrderModel> orders = [];
    for (var order in json['data']['orders']) {
      orders.add(OrderModel.fromJson(order));
    }
    return orders;
  }
}
