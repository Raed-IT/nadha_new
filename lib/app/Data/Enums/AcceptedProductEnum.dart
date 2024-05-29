enum AcceptedProductEnum { accepted, pending, rejected }

extension AcceptedProductEnumStringExtention on String {
  String toAcceptedProductName() {
    if (this == AcceptedProductEnum.accepted.name) {
      return "تمت الموافقة";
    } else if (this == AcceptedProductEnum.pending.name) {
      return "قيد المراجعة";
    } else {
      return "تم الرفض";
    }
  }
}
