import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridListLoading extends StatelessWidget {
  final double? height;
  final BorderRadius? borderRadius;
  final int? generateCount;

  const GridListLoading(
      {super.key, this.height, this.borderRadius, this.generateCount});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 30.h,
      children: List.generate(
          20,
          (index) => CardLoadingComponent(
                height: height,
                borderRadius: BorderRadius.circular(10.sp),
              )).toList(),
    );
  }
}
