enum GenderTypeEnum { male, female }

extension OrderStatusStringExtention on GenderTypeEnum {
  String toGenderName() {
    switch (this) {
      case GenderTypeEnum.female:
        return "امرأة";
      case GenderTypeEnum.male:
        return "رجل";
    }
  }
}
