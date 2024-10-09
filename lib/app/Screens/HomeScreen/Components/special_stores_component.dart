import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpecialStoresComponent extends StatelessWidget {
  final List<StoreModel> stores;
  final RxBool isLoad;
  const SpecialStoresComponent({super.key, required this.stores, required this.isLoad});

  @override
  Widget build(BuildContext context) {
    double _cardHieght =220.h;
    double _cardWidth =240.h;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            "متاجر موصى بها",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15.sp),
          ),
        ),
        Obx(
          () => Container(
            padding: EdgeInsets.only(right: 24.w),
            height: _cardHieght,
            width: Get.width,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  return _buildCard(stores[index]);
                }),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(StoreModel store) {
    return GestureDetector(
      onTap: ()=>Get.toNamed(AppRoutes.showStore,arguments: {"store":store}),
      child: SizedBox(
        height: 200.h,
        width: 150.w,
        child: Card(
          elevation: 5,
          shadowColor: Colors.black12,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: Column(
              children: [
                ImageCacheComponent(
                  borderRadius: BorderRadius.circular(10.sp),
                  image: "${store.image}",
                  height: 135.h,
                  width: 135.h,
                ),
                8.verticalSpace,
                Text(
                  "${store.name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13.sp),
                ),
                8.verticalSpace,
                Text(
                  "${store.info}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:
                      TextStyle(fontSize: 12.sp, color: AppColors.highLightColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
