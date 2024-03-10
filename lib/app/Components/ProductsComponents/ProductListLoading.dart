import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductLoadingList extends StatelessWidget {
  const ProductLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1 / 1.25,
      crossAxisSpacing: 10.sp,
      mainAxisSpacing: 10.h,
      children: List.generate(
        10,
        (index) => CardLoadingComponent(
          borderRadius: BorderRadius.circular(10.sp),
        ),
      ),
    );
  }
}
