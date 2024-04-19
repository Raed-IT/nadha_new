import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';

class CartItemModel {
  ProductModel? product;
  RxDouble? qty;
  double? price;
   ProductUnitTypeEnum? unit ;
  String get total {
    double total = 0.0;
    if (product?.unit == ProductUnitTypeEnum.kg ||
        product?.unit == ProductUnitTypeEnum.piece) {
      total = double.parse(product!.getPrice!) * qty!.value;
    } else if (product?.unit == ProductUnitTypeEnum.amount) {
      total = (double.parse(product!.getPrice!) * qty!.value) / 1000;
    } else {
      total = qty!.value;
    }
    //(double.parse(product!.getPrice!) * qty!.value).toStringAsFixed(1)
    return total.toStringAsFixed(2);
  }

  String get quantity {
    if (product?.unit == ProductUnitTypeEnum.piece) {
      return "${qty!.value.toInt()}";
    } else {
      return qty!.value.toStringAsFixed(1);
    }
  }

  CartItemModel({
    required this.unit,
    required this.product,
    required this.qty,
    required this.price,
  });




/*
 E/flutter ( 4845): [ERROR:flutter/runtime/dart_isolate.cc(144)] Could not prepare isolate.
  E/flutter ( 4845): [ERROR:flutter/runtime/runtime_controller.cc(462)] Could not create root isolate.
  E/flutter ( 4845): [ERROR:flutter/shell/common/shell.cc(669)] Could not launch engine with configuration.
  D/FlutterLocationService( 4845): Creating service.
  */
  CartItemModel.fromJson(Map<String, dynamic> json) {
    if (json["product"] != null) {
      product = ProductModel.fromJson(json['product']);
    }
    unit = "${json['unit']}".toProductUnitTyp();
    qty = RxDouble(double.tryParse("${json['quantity']}") ?? 0);
    price = double.tryParse("${json['price']}");

  }
}
