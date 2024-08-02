import 'dart:math';

import 'package:card_loading/card_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardLoadingComponent extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsets? cardMargin;

  const CardLoadingComponent(
      {super.key, this.height, this.width, this.borderRadius, this.cardMargin});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: CardLoading(
        withChangeDuration: true,
        borderRadius: borderRadius,
        margin: cardMargin ?? EdgeInsets.all(10.sp),
        animationDuration: Duration(milliseconds: Random().nextInt(3000) + 100),
        height: height ?? 100.h,
        width: width,
      ),
    );
  }
}
