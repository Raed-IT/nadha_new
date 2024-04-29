enum AcceptedProductEnum { accepted, pending, rejected }

extension AcceptedProductEnumStringExtention on String {
  String toAcceptedProductName() {
    if (this == AcceptedProductEnum.accepted.name) {
      return "تمة الموافقة";
    } else if (this == AcceptedProductEnum.pending.name) {
      return "قيد المراجعة";
    } else {
      return "تم الرفض";
    }
  }
}
