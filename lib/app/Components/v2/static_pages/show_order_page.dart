import 'package:cached_network_image/cached_network_image.dart';
import 'package:delevary/app/Components/AppBarComponents/v2/appBar/appbar_with_title.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/OrderModel.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShowOrderScreen extends StatelessWidget {
  final OrderModel order;

  const ShowOrderScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWithTitleComponent(
            title: "رقم الطلب :${order.id}",
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Row(
              children: [
                Text(
                  " ${order.createdAt}  ",
                  style: TextStyle(
                      color: AppColors.highLightColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...order.orderItems!
                      .map((item) => buildCard(item, context))
                      .toList(),
                  Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Column(
                      children: [
                        buildRow(val: "${order.totalAmount}",label: "قيمة المشتريات :"),
                        buildRow(val: "${order.deliveryPrice}",label: "رسوم التوصيل :"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Row(
                            children: [
                              Text(
                                "المبلغ الكلي :",
                                style:   TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),
                              ),
                              Spacer(),
                              Text(
                                ((order.totalAmount??0 )+ (order.deliveryPrice??0)).toStringAsFixed(1),
                                style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.highLightColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCard(CartItemModel cartItem, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.w),
      height: 118.h,
      width: Get.width,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          SizedBox(height: 118.h, width: Get.width - 50.w, child: Card()),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                ImageCacheComponent(
                  image: "${cartItem.product?.image}",
                  width: 80.sp,
                  height: 80.sp,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${cartItem.product?.name}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.sp),
                          ),
                          Text(
                            "/${cartItem.product?.store?.name} ",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.highLightColor),
                          ),
                        ],
                      ),
                      BuildPriceProductComponent(
                          product: Rx(cartItem.product!), size: 10.sp),
                      8.verticalSpace,
                      Row(
                        children: [
                          Text(
                            " ${cartItem.quantity ?? ''} ${cartItem.unit!.toProductUnitShort()} / ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          Text(
                            "${double.parse(cartItem.total)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget buildRow({required String label, required String val}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            val,
            style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.highLightColor),
          ),
        ],
      ),
    );
  }

}
