enum MaritalStatusEnum { single, married, divorced }

extension OrderStatusStringExtention on MaritalStatusEnum {
  String toMaritalName() {
    switch (this) {
      case MaritalStatusEnum.divorced:
        return "مطـلـق";
      case MaritalStatusEnum.married:
        return "مـتـزوج";
      case MaritalStatusEnum.single:
        return "اعـزب";
    }
  }
}
