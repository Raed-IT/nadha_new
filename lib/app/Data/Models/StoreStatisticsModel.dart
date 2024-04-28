import 'package:logger/logger.dart';

class StoreStatisticsModel {
  int? products;
  int? categories;
  int? sliders;
  int? productsSeal;

  StoreStatisticsModel(
      this.products, this.categories, this.sliders, this.productsSeal);

  StoreStatisticsModel.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    categories = json['categories'];
    sliders = json['sliders'];
    productsSeal = json['products_seal'];

  }
}
