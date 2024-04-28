import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Screens/Store/StoreScreen/StoreScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoreCardComponent extends GetView<StoreScreenController> {
  const StoreCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        50.verticalSpace,
        SizedBox(
          height: 200.h,
          width: Get.width,
          child: Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
                topLeft: Radius.circular(500.sp),
              ),
            ),
            margin: EdgeInsets.all(10.sp),
            child: Transform.translate(
              offset: Offset(0, -30.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: ImageCacheComponent(
                        image: "${controller.store.image}",
                        height: 120.h,
                        width: 200,
                        borderRadius: BorderRadius.circular(10.sp),
                        fit: BoxFit.cover,
                      )
                          .animate()
                          .elevation(
                            duration: 1000.ms,
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20.sp),
                          )
                          .slideY(begin: 1, duration: 300.ms),
                    ),
                    15.verticalSpace,
                    Text(
                      "${controller.store.name}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        "${controller.store.info}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
