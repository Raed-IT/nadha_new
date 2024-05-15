import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Data/Enums/OrderStatusEnum.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/OrderModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Screens/OrdersSecreens/OrdersSecreen/OrdersSecreenController.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../route/routs.dart';

class OrdersListComponent extends GetView<OrdersScreenController> {
  const OrdersListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !controller.isLoadPaginationData.value
          ? controller.paginationData.isNotEmpty
              ? Column(
                  children: controller.paginationData
                      .map((order) =>
                          buildCardOrder(order: order, context: context))
                      .toList(),
                )
              : noOrderWidget()
          : Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                children: List.generate(20, (index) => index)
                    .map(
                      (e) => CardLoadingComponent(
                        cardMargin: EdgeInsets.symmetric(vertical: 10.sp),
                        borderRadius: BorderRadius.circular(5.sp),
                        height: 100.h,
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }

  Widget noOrderWidget() {
    return Container();
  }

  Widget buildCardOrder(
      {required OrderModel order, required BuildContext context}) {
    return SizedBox(
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
                  ),
                  Text(
                    "${order.id}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text("الحالة  :  "),
                  Text(
                    order.status!.toOrderStatus(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              30.verticalSpace,
              Column(
                children: [
                  ...order.orderItems!.map(
                    (cartItem) {
                      return buildProductCard(
                        cartItem: cartItem,
                        context: context,
                      );
                    },
                  ).toList(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                      ),
                    ),
                    child: BlurryContainer(
                      padding: EdgeInsets.all(10.sp),
                      width: Get.width,
                      height: 90.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("إجمالي الطلب :  ${order.totalAmount}"),
                          Text("الــتــوصــيـــل :  ${order.deliveryPrice}"),
                          Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                          ),
                          Text(
                              "الإجــمــالــي  :  ${order.totalAmount! + order.deliveryPrice!}"),
                        ],
                      ),
                    ),
                  ),
                  if (order.driver != null)
                    Row(
                      children: [
                        10.horizontalSpace,
                        Icon(
                          FontAwesomeIcons.whatsapp,
                          size: 20.sp,
                        ),
                        TextButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                "https://wa.me/${order.driver?.phone?.replaceAll('+', "")}"));
                          },
                          child: Text(
                            "انقر للتواصل مع السائق ${order.driver?.name}",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Text(
                        "العنوان : ${order.address?.name}",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductCard(
      {required CartItemModel cartItem, required BuildContext context}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
      ),
      width: Get.width,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.showProduct,
                  preventDuplicates: false,
                  arguments: {"product": cartItem.product, "hero": "order_"});
              Get.put(ShowProductScreenController(),
                  tag: "show_product${cartItem.product!.id}");
            },
            child: SizedBox(
              height: 100.h,
              child: Stack(
                children: [
                  Hero(
                    tag: "order_${cartItem.product?.id}",
                    child: ImageCacheComponent(
                      borderRadius: BorderRadius.circular(10.sp),
                      image: "${cartItem.product?.image}",
                      height: 100.sp,
                      width: 100.sp,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 30.h,
                      width: 100.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.sp),
                          bottomLeft: Radius.circular(10.sp),
                        ),
                        gradient: const LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent]),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          "${cartItem.product?.store?.name}",
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "${cartItem.product?.name}",
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                  5.verticalSpace,
                  AutoSizeText(
                    "${cartItem.product?.info}",
                    maxLines: 1,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      (cartItem.product != null)
                          ? BuildPriceProductComponent(
                              product: Rx(cartItem.product!), size: 10.sp)
                          : SizedBox(),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            "${cartItem.quantity ?? ''} / ",
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
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
