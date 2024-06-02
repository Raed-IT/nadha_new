import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/CartScreen/CartScreenController.dart';
import 'package:delevary/app/Screens/CartScreen/Components/CartEmptyComponent.dart';
import 'package:delevary/app/Screens/CartScreen/Components/ShowConfiermCartDialog.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Components/AppBarComponents/AppBarComponent.dart';
import '../../Components/DrawerComponents/DrawerComponent.dart';
import '../../Components/ProductsComponents/AddToCartComponent.dart';
import '../AddressesScreens/Components/showAddressesBottomSheet.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartScreenController>(
      builder: (controller) => Scaffold(
        drawerEnableOpenDragGesture: false,
        drawer: const DrawerComponent(),
        body: Builder(
          builder: (context) => Container(
            height: Get.height,
            color: Theme.of(context).colorScheme.background,
            child: Stack(
              children: [
                Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.1,
                      repeat: ImageRepeat.repeat,
                      image: AssetImage('assets/images/bg.png'),
                    ),
                  ),
                ).animate().blur(
                      delay: 50.ms,
                      begin: const Offset(20, 20),
                      duration: 1500.ms,
                    ),
                Column(
                  children: [
                    AppBarComponent(
                      openDrawer: () {
                        Scaffold.of(context).openDrawer();
                      },
                      title: "السلة",
                    ),
                    Obx(
                      () => (Get.find<MainController>().cart.isNotEmpty)
                          ? Row(
                              children: [
                                buildCardStatistic(
                                  context,
                                  title: "اجمالي الطلب",
                                  isMainCard: true,
                                  content: ((Get.find<MainController>()
                                                  .setting
                                                  .value
                                                  ?.deliveryPrice ??
                                              0) +
                                          controller.cartService.getTotal())
                                      .toStringAsFixed(2),
                                ),
                                buildCardStatistic(context,
                                    title: "اجور توصيل",
                                    content:
                                        "${Get.find<MainController>().setting.value?.deliveryPrice ?? 0}"),
                                buildCardStatistic(
                                  context,
                                  title: "اجمالي المنتجات ",
                                  content: controller.cartService
                                      .getTotal()
                                      .toStringAsFixed(2),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    Expanded(
                      child: Obx(
                        () => (Get.find<MainController>().cart.isEmpty)
                            ? const CartEmptyComponent()
                            : ListView(
                                padding: const EdgeInsets.all(0),
                                physics: const BouncingScrollPhysics(),
                                children: Get.find<MainController>()
                                    .cart
                                    .map(
                                      (cartItem) => buildCartItemCard(
                                              controller: controller,
                                              cartItem: cartItem,
                                              context: context)
                                          .animate()
                                          .slideY(begin: 1),
                                    )
                                    .toList(),
                              ),
                      ),
                    ),
                    Obx(() => (Get.find<MainController>().cart.isNotEmpty &&
                            Get.find<MainController>().setting.value!.isClose!)
                        ? buildSubmeitCard(controller: controller)
                        : Container()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCardStatistic(
    BuildContext context, {
    required String title,
    required String content,
    bool isMainCard = false,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.sp),
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(
              color: isMainCard
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary),
        ),
        child: BlurryContainer(
          borderRadius: BorderRadius.circular(10.sp),
          blur: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                maxLines: 1,
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMainCard
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary),
              ),
              10.verticalSpace,
              AutoSizeText(
                content,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ).animate().slideY(begin: 1, duration: (Random().nextInt(500) + 200).ms),
    );
  }

  Widget buildSubmeitCard({required CartScreenController controller}) {
    return Column(
      children: [
        Obx(
          () => (Get.find<MainController>().selectedAddress.value == null)
              ? GestureDetector(
                  onTap: () => showAddressesBottomSheet(context: context),
                  child: SizedBox(
                    height: 70.h,
                    width: Get.width,
                    child: Card(
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Center(
                        child: Text(
                          "أختيار موقع الطلب",
                          style:
                              TextStyle(color: Theme.of(context).colorScheme.background),
                        ),
                      ),
                    ),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => showConfirmCartDialog(context, () {
                          // Get.back();
                          controller.createOrder(context);
                        }, controller),
                        child: SizedBox(
                          height: 70.h,
                          width: Get.width,
                          child: Card(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Center(
                              child: Text(
                                " إطلب الى ${Get.find<MainController>().selectedAddress.value!.name}",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await showAddressesBottomSheet(context: context);
                          setState(() {});
                        },
                        child: SizedBox(
                          height: 70.h,
                          width: Get.width,
                          child: Card(
                            color: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Center(
                              child: Text(
                                "تبديل الموقع",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        )
      ],
    );
  }

  Widget buildCartItemCard(
      {required CartItemModel cartItem,
      required BuildContext context,
      required CartScreenController controller}) {
    return SizedBox(
      height: 160.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.sp),
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.showProduct,
                          arguments: {
                            "product": cartItem.product,
                            "hero": 'cart'
                          },
                        );
                        Get.put(ShowProductScreenController(),
                            tag: "show_product${cartItem.product!.id}");
                      },
                      child: SizedBox(
                        width: 85.sp,
                        height: 85.sp,
                        child: Stack(
                          children: [
                            Hero(
                              tag: "cart${cartItem.product!.id}",
                              child: ImageCacheComponent(
                                borderRadius: BorderRadius.circular(10.sp),
                                image: "${cartItem.product!.image}",
                                width: 85.sp,
                                height: 85.sp,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 85.sp,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10.sp),
                                    bottomLeft: Radius.circular(10.sp),
                                  ),
                                  gradient: const LinearGradient(
                                    end: Alignment.topCenter,
                                    begin: Alignment.bottomCenter,
                                    colors: [Colors.black, Colors.transparent],
                                  ),
                                ),
                                child: Center(
                                  child: AutoSizeText(
                                    "${cartItem.product?.store?.name}",
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
                            Text(
                              "${cartItem.product!.name}",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AutoSizeText(
                              "${cartItem.product!.info}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "الإجمالي",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp),
                        ),
                        10.verticalSpace,
                        Text(cartItem.total)
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Row(
                    children: [
                      Expanded(
                        child: BuildPriceProductComponent(
                          product: Rx(cartItem.product!),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            // build cart Card Counter
                            // if (cartItem.unit == ProductUnitTypeEnum.piece)
                            AddToCardComponent(
                              showEditIcon: false,
                              product: cartItem.product!,
                              onSetState: () => setState(() {}),
                            ),
                            // End build cart Card Counter

                            //build cart Card addButton
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                controller.cartService
                                    .removeFromCart(product: cartItem.product!);
                                setState(() {});
                              },
                              child: SizedBox(
                                width: 40.sp,
                                height: 40.sp,
                                child: Card(
                                  child: Center(
                                    child: Icon(
                                      Icons.delete,
                                      size: 20.sp,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ).animate().scale(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
