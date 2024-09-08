import 'package:flutter/material.dart';

 import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../them/app_colors.dart';

class DiscountPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Horizontal line
    Paint paint_1 = new Paint()
      ..color = AppColors.highlight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.34;

    Path path_1 = Path();
    path_1.moveTo(-1.w, size.height - 0.h);
    path_1.lineTo(size.width, -1.h);
    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
