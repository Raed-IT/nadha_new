import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Components/TextFieldComponent.dart';
import 'package:delevary/app/Data/Enums/OrderStatusEnum.dart';
import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/OrderModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Screens/OrdersSecreens/OrdersSecreen/OrdersSecreenController.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:delevary/app/Screens/Store/Orders/OrderStoreScreenController.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../route/routs.dart';

class OrdersStoreListComponent extends GetView<OrderStoreScreenController> {
  const OrdersStoreListComponent({super.key});

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
    bool showTime = false;
    TextEditingController infoController = TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...order.orderItems!.map(
                    (cartItem) {
                      if (cartItem.product?.category?.isShowTime ?? false) {
                        showTime = true;
                      }
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
                          Row(
                            children: [
                              Text("الإجمالي :  ${order.total}"),
                              Text(
                                "₺",
                                style: TextStyle(
                                    fontFamily: "",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 12.sp),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("العمولة :  ${order.percentAmount}"),
                              Text(
                                "₺",
                                style: TextStyle(
                                    fontFamily: "",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 12.sp),
                              )
                            ],
                          ),
                          Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                          ),
                          Row(
                            children: [
                              Text("الصافي  :  ${order.total-double.parse(order.percentAmount)}"),
                              Text(
                                "₺",
                                style: TextStyle(
                                    fontFamily: "",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 12.sp),
                              )
                            ],
                          ),
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
                  10.verticalSpace,
                  Text(
                    "العنوان : ${order.address?.name}",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                  if (!order.isStarted! && showTime)
                    Divider(
                      height: 50.h,
                    ),
                  if (!order.isStarted! && showTime)
                    Text(
                      'املاء الوقت المتوقع لاستلام الطلب ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (!order.isStarted! && showTime)
                    Column(
                      children: [
                        TextFieldComponent(
                          // autofocus: true,
                          controller: infoController,
                          hint: "الوقت المتوقع",
                          validator: (data) {
                            if (data!.isEmpty) {
                              return "الرجاء تزيدنا بالوقت المتوقع";
                            }
                            return null;
                          },
                        ),
                        10.verticalSpace,
                        GestureDetector(
                          onTap: () {
                            if (infoController.text.isEmpty) {
                              ToastService.showErrorToast(
                                  context: context,
                                  title:
                                      "الرجاء كتابة الزمن اللازم لتجهير الطلب");
                              return;
                            }
                            controller.receiveOrder(
                                order, context, infoController);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                color: Theme.of(context).colorScheme.primary),
                            child: Center(
                              child: Text(
                                "تم استلام الطلب",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ),
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
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.sp),
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
                      arguments: {
                        "product": cartItem.product,
                        "hero": "order_"
                      });
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
                              cartItem.product?.store?.name??'',
                              maxLines: 2,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
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
                        "${cartItem.product?.name??'منتج محذوف'}",
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      5.verticalSpace,
                      AutoSizeText(
                        "${cartItem.product?.info??'منتج محذوف'}",
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
                                "${cartItem.unit!.toProductUnitShort()}${cartItem.quantity ?? ''} / ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              Text(
                                "${double.parse(cartItem.total)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              Text(
                                "₺",
                                style: TextStyle(
                                    fontFamily: "",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 12.sp),
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
        ),
        Positioned(
          left: 20.w,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.sp)),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            ),
            child: BlurryContainer(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              borderRadius: BorderRadius.all(
                Radius.circular(10.sp),
              ),
              child: Center(
                  child: Text('%${cartItem.product?.category?.percent ?? 0}')),
            ),
          ),
        )
      ],
    );
  }
}
