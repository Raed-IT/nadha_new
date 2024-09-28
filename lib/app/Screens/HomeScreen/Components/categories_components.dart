import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoriesComponent extends StatelessWidget {
  final RxBool isLoading;
  final List<CategoryModel> categories;

  const CategoriesComponent(
      {super.key, required this.isLoading, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                Text(
                  "الفئات",
                  style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 15.sp),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.categoriesV2,   );
                  },
                  child: Row(
                    children: [
                      Text(
                        "عرض الكل",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.highLightColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15.sp,
                        color: AppColors.highLightColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
