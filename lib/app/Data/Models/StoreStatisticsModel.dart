import 'package:delevary/app/Data/MainController.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class StoreStatisticsModel {
  int? products;
  int? categories;
  int? sliders;
  int? productsSeal;
  double? storeBalance;

  StoreStatisticsModel(
      this.products, this.categories, this.sliders, this.productsSeal);

  StoreStatisticsModel.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    categories = json['categories'];
    sliders = json['sliders'];
    productsSeal = json['products_seal'];
    storeBalance = double.tryParse("${json['store_balance']}");
    Get.find<MainController>().user.value?.balance = storeBalance;
  }
}
