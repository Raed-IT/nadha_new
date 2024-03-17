import 'package:delevary/app/Data/Enums/OrderStatusEnum.dart';
import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';

class OrderModel {
  int? id;
  double? totalAmount;
  AddressModel? address;
  OrderStatusEnum? status;
  String? createdAt;
  String? note;
  bool? isFinished;
  List<CartItemModel>? orderItems;

  OrderModel(this.id, this.totalAmount, this.address, this.status,
      this.createdAt, this.note, this.isFinished);

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = double.tryParse("${ json['total_amount']}");
    if (json['address'] != null) {
      address = AddressModel.fromJson(json['address']);
    }
    status = "${json['status']}".toOrderStatus();
    createdAt = json['created_at'];
    note = json['note'];
    isFinished = json['is_finished'] as bool;
    orderItems = [];
    if (json['items'].isNotEmpty) {
      for (var item in json['items']) {
        orderItems!.add(CartItemModel.fromJson(item));
      }
    }
  }
}
