import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerticalListLoading extends StatelessWidget {
  final double? height;
  final BorderRadius? borderRadius;
  final int? generateCount;

  const VerticalListLoading(
      {super.key, this.height, this.borderRadius, this.generateCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        generateCount ?? 20,
        (index) => CardLoadingComponent(
          borderRadius: borderRadius,
          height: height,
          width: Get.width,
        ),
      ),
    );
  }
}
