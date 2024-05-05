import 'package:delevary/app/Data/MainController.dart';
import 'package:get/get.dart';

class TransformModel {
  int? id;
  int? senderId;
  int? receiveId;
  double? amount;
  String? info;
  int? orderId;

  String? createdAt;

  bool get isSender =>
      senderId == Get.find<MainController>().user.value?.store?.id;

  TransformModel(this.id, this.senderId, this.receiveId, this.amount, this.info,
      this.orderId);

  TransformModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    createdAt = json['created_at'];
    receiveId = json['receive_id'];
    amount = double.tryParse("${json['amount']}");
    info = json['info'];
    orderId = json['order_id'];
  }
}
