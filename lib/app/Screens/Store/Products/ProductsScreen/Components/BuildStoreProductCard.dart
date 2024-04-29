import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/Enums/AcceptedProductEnum.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildStoreProductCardComponent extends StatelessWidget {
  final ProductModel product;

  const BuildStoreProductCardComponent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: BlurryContainer(
          blur: 7,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100.sp,
                    width: 120.sp,
                    child: Stack(
                      children: [
                        ImageCacheComponent(
                          borderRadius: BorderRadius.circular(10.sp),
                          image: "${product.image}",
                          height: 100.sp,
                          width: 120.sp,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.sp),
                                bottomLeft: Radius.circular(10.sp),
                              ),
                              gradient: LinearGradient(
                                end: Alignment.topCenter,
                                begin: Alignment.bottomCenter,
                                colors: [
                                  if (product.isAccepted ==
                                      AcceptedProductEnum.pending.name) ...[
                                    Theme.of(context).colorScheme.secondary,
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.1)
                                  ],
                                  if (product.isAccepted ==
                                      AcceptedProductEnum.accepted.name) ...[
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1)
                                  ],
                                  if (product.isAccepted ==
                                      AcceptedProductEnum.rejected.name) ...[
                                    Colors.red,
                                    Colors.red.withOpacity(0.1)
                                  ]
                                ],
                              ),
                            ),
                            width: 120.sp,
                            child: AutoSizeText(
                              textAlign: TextAlign.center,
                              "${product.isAccepted?.toAcceptedProductName()}",
                              maxLines: 1,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "${product.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        10.verticalSpace,
                        AutoSizeText(
                          "${product.info}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
