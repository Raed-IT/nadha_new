import 'package:delevary/app/Data/MainController.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class StoreStatisticsModel {
  int? products;
  int? sliders;
  int? ordersCount;
  double? storeBalance;

  StoreStatisticsModel(this.products, this.sliders);

  StoreStatisticsModel.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    ordersCount = json['orders_count'];
    sliders = json['sliders'];
    storeBalance = double.tryParse("${json['store_balance']}");
    Get.find<MainController>().user.value?.balance = storeBalance;
  }
}
