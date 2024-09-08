import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/product_item_model.dart';
import 'package:nadha/app/data/model/product_model.dart';

import '../enums/unit_product_type_enum.dart';
import '../helper.dart';

class CartItemModel {
  int? id;

  /// locale usage
  int? cityId;

  /// locale usage

  RxDouble? quantity;
  RxString? status;

  double? price = 0;

  double? totalPrice;

  String? store;

  ///[product] locale product from ui
  ProductModel? product;

  ///[ fromAmount] locale value store if cartitem choses price or wight
  bool get fromAmount {
    return price != null && price! > 0;
  }

  CartItemModel(this.quantity, this.product, this.price);

  double get localTotalPrice {
    if (fromAmount) {
      return price!;
    } else {
      double price = 0;
      //get price
      if (product!.isDiscount!) {
        price = product!.discount!;
      } else {
        price = product!.price!;
      }
      if (product!.unit == UnitProductType.gram.name) {
        return (price / 1000) * quantity!.value;
      } else {
        return price * quantity!.value;
      }
    }
  }

  CartItemModel.fromJson(Map<String, dynamic> json) {
    status = RxString(json['status']);
    id = json['id'];
    if (json['product'] != null) {
      product = ProductModel.fromJson(json['product']);
    }
    if (json["quantity"] != null) {
      quantity = RxDouble(
        double.parse(
          json["quantity"].toString(),
        ),
      );
    }
    if (json.containsKey("city_id")) {
      cityId = json['city_id'];
    }
    if (json["price"] != null) {
      price = double.tryParse(json["price"].toString());
    }
    totalPrice = double.tryParse(json["total"].toString());
    store = json["store"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['quantity'] = quantity?.value;
    data['product'] = product!.toJson();
    data['totalPrice'] = totalPrice;
    data['store'] = store;
    data['status'] = "";
    data['city_id'] = Get.find<MainController>().user.value?.cityId;
    return data;
  }
}
