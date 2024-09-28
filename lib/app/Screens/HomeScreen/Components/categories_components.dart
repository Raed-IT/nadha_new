import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';

class CategoriesComponent extends StatelessWidget {
  final RxBool isLoading;
  final List<CategoryModel> categories;

  const CategoriesComponent(
      {super.key, required this.isLoading, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104.h,
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
                    Get.toNamed(AppRoutes.categoriesV2,
                        arguments: {"categories": categories});
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
                ),
              ],
            ),
          ),
          Obx(
          ()=> SizedBox(
              width: Get.width,
              height: 42.h,
              child: ListView.builder(
                physics:const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: ()=>Get.toNamed(AppRoutes.categoryProducts,arguments: {"category":categories[index]}),
                  child: SizedBox(
                    height: 24.h,
                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.black38,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black12.withOpacity(0.1)
                        ),
                        borderRadius: BorderRadius.circular(500)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 0),
                        child: Center(
                          child: Text("${categories[index].name}"),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
