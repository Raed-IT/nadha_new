import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/MediaModel.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';

class ProductModel {
  int? id;
  String? name;
  String? info;
  ProductUnitTypeEnum? unit;
  bool? isDiscount;
  double? price;
  double? discount;
  String? currency;
  String? image;
  CategoryModel? category;
  StoreModel? store;
  List<MediaModel>? images;

  double? get getPrice {
    if (isDiscount ?? false) {
      return discount;
    }
    return price;
  }

  String? get getUnitName {
    return " / ${unit!.toProductUnit()}";
  }



  ProductModel(
      {this.id,
      this.name,
      this.info,
      this.unit,
      this.isDiscount,
      this.price,
      this.discount,
      this.currency});

  ProductModel.fromJson(Map<String, dynamic> json) {
    images = [];

    if (json['images'].length > 0) {
      json['images'].keys!.forEach((key) {
        int id = int.parse("$key");
        String image = json['images'][key];
        images!.add(MediaModel(id, image));
      });
    }
    id = json['id'];
    image = json['image'];
    name = json['name'];
    info = json['info'];
    unit = "${json['unit']}".toProductUnitTyp();
    isDiscount = json['is_discount'];
    price = double.tryParse("${json['price']}");
    discount = double.tryParse("${json['discount']}");
    currency = json['currency'];
    category = CategoryModel.fromJson(json['category']);
    store = StoreModel.fronJson(json['store']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['info'] = this.info;
    data['unit'] = this.unit;
    data['is_discount'] = this.isDiscount;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['currency'] = this.currency;
    return data;
  }
}
