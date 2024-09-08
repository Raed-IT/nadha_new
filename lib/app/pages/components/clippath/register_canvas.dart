import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../them/app_colors.dart';

class RegisterClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    path.lineTo(0, 500.h);
    path.lineTo(size.width, 500.h);
    path.lineTo(size.width, 50.h);
    path.lineTo(150.w, 50.h);
    path.lineTo(120.w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
