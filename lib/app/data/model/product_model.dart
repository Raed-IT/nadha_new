import 'package:nadha/app/data/model/store_model.dart';

import '../enums/unit_product_type_enum.dart';

class ProductModel {
  int? id;
  StoreModel? store;
  String? category;
  String? name;
  String? info;
  bool? isDiscount;
  bool? isAvailable;
  double? price;
  double? maxQty;
  double? minQty;
  double? discount;
  String? unitName;
  String? unit;
  String? img;

  double get qtyNum {
    // return 0.5 if unit is kg using this getter in increment and decrement product qty in cart ...
    if (UnitProductType.kg.name == unit) {
      return 0.5;
    }
    return 1.0;
  }

  ProductModel(
      {this.id,
      this.store,
      this.category,
      this.name,
      this.info,
      this.isDiscount,
      this.isAvailable,
      this.maxQty,
      this.minQty,
      this.price,
      this.discount,
      this.unitName,
      this.unit,
      this.img});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    store = StoreModel.fromJson(json['store']);
    category = json['category'];
    name = json['name'];
    info = json['info'];
    maxQty = double.tryParse(json['max_qty'].toString()) ?? 0;
    minQty = double.tryParse(json['min_qty'].toString());
    isDiscount = json['is_discount'];
    isAvailable = json['is_available'];
    price = double.parse(json['price'].toString());
    discount = double.parse(json['discount'].toString());
    unitName = json['unit_name'];
    unit = json['unit'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['store'] = store!.toJson();
    data['category'] = category;
    data['name'] = name;
    data['info'] = info;
    data['is_discount'] = isDiscount;
    data['is_available'] = isAvailable;
    data['price'] = price;
    data['discount'] = discount;
    data['unit_name'] = unitName;
    data['unit'] = unit;
    data['img'] = img;
    return data;
  }
}
