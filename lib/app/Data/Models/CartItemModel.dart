import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';

class CartItemModel {
  ProductModel product;
  RxDouble qty;
  double price;

  String get total {
    return (double.parse(product.getPrice!) * qty.value).toStringAsFixed(1);
  }

  CartItemModel({
    required this.product,
    required this.qty,
    required this.price,
  });
}
