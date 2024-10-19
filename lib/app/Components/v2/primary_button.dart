import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrimaryButtonComponent extends StatelessWidget {
  final String label;

  final Future<void> Function()? onTap;

  const PrimaryButtonComponent({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(15.sp),
        ),
        height: 56.h,
        width: Get.width,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17.sp),
          ),
        ),
      ),
    );
  }
}
