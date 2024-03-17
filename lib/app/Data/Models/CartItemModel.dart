import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';

class CartItemModel {
  ProductModel? product;
  RxDouble? qty;
  double? price;

  String get total {
    return (double.parse(product!.getPrice!) * qty!.value).toStringAsFixed(1);
  }

  String get quantity {
    if (product!.unit == ProductUnitTypeEnum.piece) {
      return "${qty!.value.toInt()}";
    } else {
      return qty!.value.toStringAsFixed(1);
    }
  }

  CartItemModel({
    required this.product,
    required this.qty,
    required this.price,
  });

  CartItemModel.fromJson(Map<String, dynamic> json) {
    product = ProductModel.fromJson(json['product']);
    qty = RxDouble(double.tryParse("${json['quantity']}") ?? 0);
    price = double.tryParse("${json['price']}");
  }
}
