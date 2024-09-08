import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/order_model.dart';
import 'package:nadha/app/data/model/user_model.dart';

class OrdersScreenController extends GetxController
    with PaginationMixin<OrderModel> {
  bool isStore = false;
  bool isAdmin = false;
  List<UserModel> users = [];

  bool get isShowUpdateOrderButtonPermission {
    return Get.find<MainController>().user.value?.level == "admin" ||
        Get.find<MainController>().user.value?.level == "driver";
  }

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments.containsKey('isStore')) {
      isStore = Get.arguments['isStore'];
    }
    if (Get.arguments != null && Get.arguments.containsKey('isAdmin')) {
      isAdmin = Get.arguments['isAdmin'];
    }
    isLoadPagination.value = true;

    if (isStore) {
      url = ApiRouts.bills;
    } else if (isAdmin) {
      url = ApiRouts.invoices;
    } else {
      url = ApiRouts.orders;
    }
    getPaginationData(isRefresh: true);
    super.onInit();
  }

  @override
  String? getNextUrlForPaginationUsing(Map<String, dynamic> data) {
    return data['data']['nextPage'];
  }

  @override
  List<OrderModel> getModelFromPaginationJsonUsing(Map<String, dynamic> json) {
    List<OrderModel> orders = [];
    users = [];
    for (var order in json['data']['orders']) {
      orders.add(OrderModel.fromJson(order));
    }
    for (var order in json['data']['drivers']) {
      users.add(UserModel.fromJson(order));
    }
    return orders;
  }
}
