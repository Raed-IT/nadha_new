import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/MediaModel.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:get/get.dart';

class ProductModel {
  int? id;
  String? name;
  String? slug;
  String? info;
  ProductUnitTypeEnum? unit;
  bool? isDiscount;
  double? price;
  double? minQty;
  double? discount;
  String? currency;
  String? image;
  String? isAccepted;
  CategoryModel? category;
  StoreModel? store;
  List<MediaModel>? images;
  bool? isFavorite;
  bool? status;

  String? get getPrice {
    double? pr = 0;
    if (isDiscount!) {
      pr = discount;
    } else {
      pr = price;
    }
    if (currency == "USD") {
      return (pr! *
              double.tryParse(
                  "${Get.find<MainController>().setting.value!.exchange}")!)
          .toStringAsFixed(1);
    } else {
      return pr!.toStringAsFixed(1);
    }
  }

  String? get getUnitName {
    return " / ${unit!.toProductUnit()}";
  }

  bool get isShowCounter => unit == ProductUnitTypeEnum.piece;

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
    minQty = double.tryParse("${json['min_qty']}");
    if (json['images'].length > 0) {
      json['images'].keys!.forEach((key) {
        int id = int.parse("$key");
        String image = json['images'][key];
        images!.add(MediaModel(id, image));
      });
    }
    id = json['id'];
    image = json['image'];
    status = json['status'];
    isAccepted = json['is_accepted'];
    slug = json['slug'];
    name = json['name'];
    info = json['info'];
    isFavorite = json['is_favorite'] as bool;
    unit = "${json['unit']}".toProductUnitTyp();
    isDiscount = json['is_discount'] as bool;
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
