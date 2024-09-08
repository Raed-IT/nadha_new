import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../them/app_colors.dart';

class LoginClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    path.moveTo(0, 50.h);
    path.lineTo(0, 500.h);
    path.lineTo(150.w, 500.h);
    path.lineTo(150.w, 0.h);
    path.lineTo(150.w - 120.w, 0.h);
    path.lineTo(150.w - 150.w, 50.h);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
