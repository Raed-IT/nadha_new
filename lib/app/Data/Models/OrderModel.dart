import 'package:delevary/app/Data/Enums/OrderStatusEnum.dart';
import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:logger/logger.dart';

class OrderModel {
  int? id;
  UserModel? driver;
  double? deliveryPrice;
  UserModel? customer;
  double? totalAmount;
  AddressModel? address;
  OrderStatusEnum? status;
  String? createdAt;
  String? note;
  bool? isFinished;
  bool? isStarted;
  List<CartItemModel>? orderItems;

  double get total {
    double _total = 0;
    orderItems!.forEach((element) {
      _total += element.price!;
    });
    return _total;
  }

  String get percentAmount {
    // العمولة
    double percent = 0;
    for (var item in orderItems!) {
      percent += (item.price! * (item.product?.category?.percent ?? 0)) / 100;
    }
    return percent.toStringAsFixed(2);
  }

  String get orderAmount {
    // الصافي
    return "${totalAmount! - double.parse(percentAmount)}";
  }

  OrderModel(this.id, this.totalAmount, this.address, this.status,
      this.createdAt, this.note, this.isFinished);

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryPrice = double.tryParse("${json['delivery_price']}");
    if (json['delivery'] != null) {
      driver = UserModel.fromJson(json['delivery']);
    }
    totalAmount = double.tryParse("${json['total_amount']}");
    if (json['address'] != null) {
      address = AddressModel.fromJson(json['address']);
    }
    if (json.containsKey('user') && json['json'] != null) {
      customer = UserModel.fromJson(json['user']);
    }
    status = "${json['status']}".toOrderStatus();
    createdAt = json['created_at'];
    note = json['note'];
    isFinished = json['is_finished'] as bool;
    isStarted = json['is_started'] as bool;
    orderItems = [];
    if (json['items'].isNotEmpty) {
      for (var item in json['items']) {
        orderItems!.add(CartItemModel.fromJson(item));
      }
    }
  }
}
