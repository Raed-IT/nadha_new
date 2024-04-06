import 'package:flutter/material.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

extension RefreshExtention on Widget {
  Widget refreshAbel({required Future Function() onRefresh}) {
    return CustomMaterialIndicator(
      backgroundColor: Colors.transparent,
      elevation: 0,
      withRotation: false,
      clipBehavior: Clip.none,
      leadingScrollIndicatorVisible: true,
      indicatorBuilder:
          (BuildContext context, IndicatorController controller) => Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 5.h,
            width: 80.w,
            child: Lottie.asset(
              "assets/json/delevary_motor.json",
              fit: BoxFit.cover,
              height: 80.h,
            ),
          )
              .animate()
              .slideX(begin: -3, duration: 2500.ms, curve: Curves.elasticOut),
        ],
      ),
      onRefresh: () async {
        return await onRefresh();
      },
      child: this,
    );
  }
}
