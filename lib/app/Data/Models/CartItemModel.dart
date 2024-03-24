import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';

class CartItemModel {
  ProductModel? product;
  RxDouble? qty;
  double? price;

  String get total {
    double total = 0.0;
    if (product?.unit == ProductUnitTypeEnum.kg ||
        product?.unit == ProductUnitTypeEnum.piece) {
      total = double.parse(product!.getPrice!) * qty!.value;
    } else if (product?.unit == ProductUnitTypeEnum.amount) {
      total = (double.parse(product!.getPrice!)*qty!.value) /1000 ;
    } else {
      total =  qty!.value;
    }
    //(double.parse(product!.getPrice!) * qty!.value).toStringAsFixed(1)
    return total.toStringAsFixed(2);
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
