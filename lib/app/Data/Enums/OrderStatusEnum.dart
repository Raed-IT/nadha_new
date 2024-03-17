import 'package:flutter/foundation.dart';

enum OrderStatusEnum { pending, onway, canceled, finished }

extension OrderStatusExtention on String {
  OrderStatusEnum toOrderStatus() => OrderStatusEnum.values
      .firstWhere((e) => describeEnum(e) == toLowerCase());
}

extension OrderExtention on OrderStatusEnum {
  String toOrderStatus() {
    switch (this) {
      case OrderStatusEnum.pending:
        return "في الإنتظار";
      case OrderStatusEnum.onway:
        return "في الطريق";
      case OrderStatusEnum.canceled:
        return "تم الإلغاء";
      case OrderStatusEnum.finished:
        return "منتهي";
    }
  }
}
