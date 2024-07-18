import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/DrawerComponents/DrawerComponent.dart';
import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Data/Enums/FloorEnum.dart';
import 'package:delevary/app/Data/Enums/OrderStatusEnum.dart';
import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Screens/Delivery/DeliveryOrdersScreen/Components/ConfermOrderStatusDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Components/AppBarComponents/AppBarComponent.dart';
import '../../../Components/ChachImageComponent.dart';
import '../../../Components/LoadMore.dart';
import '../../../Components/ProductsComponents/BuildPrice.dart';
import '../../../Data/Models/CartItemModel.dart';
import '../../../Data/Models/OrderModel.dart';
import '../../../Route/Routs.dart';
import '../../ShowProductScreen/ShowProductScreenController.dart';
import 'DeliveryOrdersScreenController.dart';

class DeliveryOrdersScreen extends GetView<DeliveryOrdersScreenController> {
  const DeliveryOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerComponent(),
      body: Builder(
        builder: (context) => Container(
          height: Get.height,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              AppBarComponent(
                title: "طلبات خاصة بي ",
                openDrawer: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Expanded(
                child: ListView(
                  // controller: scrollController,
                  padding: const EdgeInsets.all(0),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Obx(
                      () => !controller.isLoadPaginationData.value
                          ? controller.paginationData.isNotEmpty
                              ? Column(
                                  children: controller.paginationData
                                      .map((order) => buildCardOrder(
                                          order: order, context: context))
                                      .toList(),
                                )
                              : GestureDetector(
                                  onTap: () => controller.getDataFromApi(),
                                  child: SizedBox(
                                    height: Get.height - 200.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Opacity(
                                          opacity: .8,
                                          child: Lottie.asset(
                                              "assets/json/delevary_motor.json",
                                              height: 150.h),
                                        ),
                                        20.verticalSpace,
                                        const Text(
                                            "لايوجد طلبات انقر للتحديث .. "),
                                      ],
                                    ),
                                  ),
                                )
                          : Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: Column(
                                children:
                                    List.generate(20, (index) => index)
                                        .map(
                                          (e) => CardLoadingComponent(
                                            cardMargin:
                                                EdgeInsets.symmetric(
                                                    vertical: 10.sp),
                                            borderRadius:
                                                BorderRadius.circular(5.sp),
                                            height: 100.h,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                    ),
                    LoadMoreComponent(
                      isFinished: controller.isFinish,
                      isLoad: controller.isLoadMore,
                    )
                  ],
                ).refreshAbel(onRefresh: () async {
                  await controller.getDataFromApi();
                }).loadMoreAble(
                    scrollController: scrollController,
                    onLoadMore: () async {
                      await controller.loadMore();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
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
                  Text("الإجمالي  :  ${order.totalAmount?.toStringAsFixed(1)}"),
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
                  ...order.orderItems!
                      .map(
                        (cartItem) => buildProductCard(
                          cartItem: cartItem,
                          context: context,
                        ),
                      )
                      .toList(),
                  10.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "العنوان : ${order.address?.name}",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.map, arguments: {
                          "latlong":
                              LatLng(order.address!.lat!, order.address!.long!)
                        }),
                        child: Row(children: [
                          Icon(
                            FontAwesomeIcons.mapLocationDot,
                            size: 20.sp,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          10.horizontalSpace,
                          Text("عرض الخريطة"),
                        ]),
                      )
                    ],
                  ),
                  10.verticalSpace,
                  Text("الطابق :  ${order.floor?.toFloorName()??'_'}"),
                  10.verticalSpace,
                  Text("اسم المستلم : ${order.receiverName ?? '_'}"),
                  10.verticalSpace,
                  Text("ملاحظات الطلب : ${order.note ?? '_'}"),
                  TextButton(
                    onPressed: () {
                      launchUrl(Uri.parse(
                          "https://wa.me/${order.customer?.phone?.replaceAll('+', "")}"));
                    },
                    child: Row(
                      children: [
                        Icon(
                          size: 22.sp,
                          FontAwesomeIcons.whatsapp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        10.horizontalSpace,
                        Text(
                          order.customer?.phone != null
                              ? "انقر للتواصل مع صاحب الطلب"
                              : " لم يتم تعين رقم هاتف",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    minWidth: Get.width,
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () =>
                        showConfirmOrderBottomSheet(controller, context, order),
                    child: Text(
                      "تم انهاء الطلب",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Theme.of(context).colorScheme.background),
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
          SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                ImageCacheComponent(
                  borderRadius: BorderRadius.circular(10.sp),
                  image: "${cartItem.product?.image}",
                  height: 100.sp,
                  width: 100.sp,
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
                        "${cartItem.product?.store?.name ?? 'منتج محذوف'}",
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    cartItem.product?.name ?? 'منتج محذوف',
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
                            "${cartItem.unit!.toProductUnitShort()}${cartItem.quantity ?? ''} / ",
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
