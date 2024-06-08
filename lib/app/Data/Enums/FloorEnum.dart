import 'package:flutter/foundation.dart';

enum FloorEnum {
  ground,
  first,
  second,
  third,
  fourth,
  fifth,
  sixth,
  seventh,
  eighth,
  ninth,
  tenth
}

extension FloorEnumExtention on String {
  FloorEnum toFloorEnum() =>
      FloorEnum.values.firstWhere((e) => describeEnum(e) == toLowerCase());
}

extension FloorEnumStringExtention on FloorEnum {
  String toFloorName() {
    switch (this) {
      case FloorEnum.ground:
        return "القبو";
      case FloorEnum.first:
        return "الطابق الاول ";
      case FloorEnum.second:
        return "الطابق الثاني ";
      case FloorEnum.third:
        return "الطابق الثالث ";
      case FloorEnum.fourth:
        return "الطابق الرابع ";
      case FloorEnum.fifth:
        return "الطابق الخامس ";
      case FloorEnum.sixth:
        return "الطابق السادس ";
      case FloorEnum.seventh:
        return "الطابق السابع ";
      case FloorEnum.eighth:
        return "الطابق الثامن ";
      case FloorEnum.ninth:
        return "الطابق التاسع ";
      case FloorEnum.tenth:
        return "الطابق العاشر ";
    }
  }
}
