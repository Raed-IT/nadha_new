import 'package:delevary/app/Components/clippath/discount_canvas.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildPriceProductComponent extends StatelessWidget {
  final Rx<ProductModel> product;
  final double? size;

  const BuildPriceProductComponent(
      {super.key, required this.product, this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (product.value.isDiscount ?? false)
          CustomPaint(
            painter: DiscountPainter(context),
            child: Text(
              "${product.value.price}",
              style: TextStyle(
                fontSize: size ?? 13.sp,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        10.horizontalSpace,
        Text(
          "${product.value.getPrice}",
          style: TextStyle(
            fontSize: size ?? 13.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          "${product.value.getUnitName}",
          style: TextStyle(
            fontSize: size != null ? size! - 3 : 10.sp,
          ),
        ),
      ],
    );
  }
}
