import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountPainter extends CustomPainter {
  final BuildContext context;

  DiscountPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    // Horizontal line
    Paint paint_1 = new Paint()
      ..color = Theme.of(context).colorScheme.error
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
