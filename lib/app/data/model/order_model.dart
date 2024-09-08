import 'package:nadha/app/data/model/address_model.dart';

import 'cart_item_model.dart';

class OrderModel {
  int? id;
  String? fare; // اجور التوصيل
  String? orderNo;
  String? info;
  String? createdAt;
  String? status;
  String? statusEn;
  List<CartItemModel>? items;
  double? total;
  AddressModel? address;
  int? driverId;

  OrderModel(
      {this.id,
      this.orderNo,
      this.createdAt,
      this.statusEn,
      this.address,
        this.info,
      this.driverId,
      this.status,
      this.items});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fare = "${json['fare']}";
    driverId = int.tryParse("${json['driver_id']}");
    total = double.tryParse(json['total'].toString()) ?? 0;
    orderNo = json['orderNo'];
    info = json['info'];
    createdAt = json['createdAt'];
    if (json['address'] != null) {
      address = AddressModel.fromJson(json['address']);
    }
    status = json['status'];
    statusEn = json['status_en'];
    items = [];
    for (var item in json['items']) {
      items!.add(CartItemModel.fromJson(item));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderNo'] = this.orderNo;
    data['createdAt'] = this.createdAt;
    data['status'] = this.status;
    return data;
  }
}
