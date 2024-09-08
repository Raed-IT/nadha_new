enum OrderStatus { away, finish, canceled }

extension OrderStatusStringExtention on OrderStatus {
  String toOrderStatusLabel() {
    switch (this) {
      case OrderStatus.canceled:
        return "تم الإلعاء ";
      case OrderStatus.away:
        return "في الطريق";
      case OrderStatus.finish:
        return "تم التسليم";
    }
  }
}
