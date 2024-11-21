import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Components/v2/primary_button.dart';
import 'package:delevary/app/Components/v2/static_pages/show_order_page.dart';
import 'package:delevary/app/Data/Enums/OrderStatusEnum.dart';
import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/OrderModel.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CardOrderComponent extends StatelessWidget {
  final OrderModel order;

  final RxInt selectedTap;

  const CardOrderComponent(
      {super.key, required this.selectedTap, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       if (selectedTap.value== 1){
         Navigator.of(context).push(
           MaterialPageRoute(
             builder: (context) => ShowOrderScreen(
               order: order,
             ),
           ),
         );
       }
      },
      child: SizedBox(
        width: Get.width,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "رقم الطلب :  ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${order.id}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      "${order.createdAt}",
                      style: TextStyle(color: AppColors.highLightColor),
                    )
                  ],
                ),
                buildRow(label: "حالة الطلب :", val: "${order.status?.toOrderStatus()}"),

                buildRow(
                  label: "العنوان :  ",
                  val: order.address?.name ?? '-',
                ),
                buildRow(val: "عند الاستلام", label: "طريـقـة الــدفــع :  "),
                buildRow(label: "قيمة المشتريات :", val: "${order.totalAmount!}"),
                buildRow(
                    label: "رسوم التوصيل :", val: "${order.deliveryPrice!}"),
                Divider(),
                buildRow(
                    label: "المبلغ الإجمالي :",
                    val: "${order.totalAmount! + order.deliveryPrice!}"),
                10.verticalSpace,
                Visibility(
                  visible: selectedTap.value == 0,
                  child: Column(
                    children: [
                      ...order.orderItems!.map(
                        (cartItem) {
                          return buildProductCard(
                            cartItem: cartItem,
                            context: context,
                          );
                        },
                      ).toList(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
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
            style: TextStyle(color: AppColors.highLightColor),
          ),
        ],
      ),
    );
  }

  Widget buildProductCard(
      {required CartItemModel cartItem, required BuildContext context}) {
    return Row(
      children: [
        Column(
          children: [
            ImageCacheComponent(
              borderRadius: BorderRadius.circular(10000.sp),
              image: "${cartItem.product?.image}",
              height: 40.sp,
              width: 40.sp,
            ),
          ],
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        cartItem.product?.name ?? 'المنتج  غير متوفر',
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    (cartItem.product != null)
                        ? BuildPriceProductComponent(
                            product: Rx(cartItem.product!), size: 10.sp)
                        : SizedBox(),
                  ],
                ),
                5.verticalSpace,
                Row(
                  children: [
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
                        Text(
                          "₺",
                          style: TextStyle(
                              fontFamily: "",
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 10.sp),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: selectedTap.value == 0,
          child: Expanded(
            flex: 1,
            child: SizedBox(
              height: 30.h,
              child: PrimaryButtonComponent(
                label: "تقييم",
                radius: 5.sp,
                fontSize: 10.sp,
                onTap: () async {
                  Fluttertoast.showToast(msg: "قريبا سيتم تفعيل  ميزة التقييم");
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
