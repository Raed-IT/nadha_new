import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';

class CartItemModel {
  ProductModel product;
  RxInt qty;
  double price;

  double get total {
    return product.getPrice! * qty.value;
  }

  CartItemModel({
    required this.product,
    required this.qty,
    required this.price,
  });
}
