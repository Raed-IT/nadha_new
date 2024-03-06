/*
 KG => 'كيلو غرام',
 PIECE => 'قطعة',
 AMOUNT => 'كمية بالغرام',
 AMOUNT_PRICE => 'كمية بسعر  ',
* */

import 'package:flutter/foundation.dart';

enum ProductUnitTypeEnum {
  kg,
  piece,
  amount,
  amount_price,
}

extension ProductUnitExtention on String {
  ProductUnitTypeEnum toProductUnitTyp() => ProductUnitTypeEnum.values
      .firstWhere((e) => describeEnum(e) == toLowerCase());
}

extension FromProductType on ProductUnitTypeEnum {
  String toProductUnit() {
    if (this == ProductUnitTypeEnum.amount) {
      return "كمية بالغرام";
    } else if (this == ProductUnitTypeEnum.amount_price) {
      return "كمية بسعر";
    } else if (this == ProductUnitTypeEnum.kg) {
      return "كيلوغرام";
    } else {
      return "قطعة";
    }
  }
}
