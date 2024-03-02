import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalListLoading extends StatelessWidget {
  final double? height;
  final BorderRadius? borderRadius;
  final int? generateCount;

  const HorizontalListLoading(
      {super.key, this.height, this.borderRadius, this.generateCount});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.zero,
      childAspectRatio: 1 / 1.1,
      crossAxisSpacing: 00,
      mainAxisSpacing: 0,
      children: List.generate(
        generateCount ?? 20,
        (index) => CardLoadingComponent(
          cardMargin: EdgeInsets.all(5.sp),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
