import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/CartScreen/CartScreenController.dart';
import 'package:delevary/app/Screens/CartScreen/Components/CartEmptyComponent.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:delevary/app/Thems/AppColots.dart';
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
                    BlurryContainer(
                      child: Container(
                        padding: EdgeInsets.all(10.sp),
                        height: 50.h,
                        child: Row(
                          children: [
                            Text(
                              "اجمالي الطلبات",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text(
                              "${controller.cartService.getTotal()}",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
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
                    if (Get.find<MainController>().cart.isNotEmpty)
                      buildSubmeitCard(controller: controller)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSubmeitCard({required CartScreenController controller}) {
    return Obx(
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
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: const Center(
                    child: Text("أختيار موقع الطلب"),
                  ),
                ),
              ),
            )
          : Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => controller.createOrder(),
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
                                color: Theme.of(context).colorScheme.background,
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
                                color: Theme.of(context).colorScheme.background,
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
                            tag: "show_product${cartItem.product.id}");
                      },
                      child: Hero(
                        tag: "cart${cartItem.product.id}",
                        child: ImageCacheComponent(
                          borderRadius: BorderRadius.circular(10.sp),
                          image: "${cartItem.product.image}",
                          width: 85.sp,
                          height: 85.sp,
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
                              "${cartItem.product.name}",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AutoSizeText(
                              "${cartItem.product.info}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(cartItem.total)
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
                          product: Rx(cartItem.product),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            AddToCardComponent(
                              product: cartItem.product,
                              onSetState: () => setState(() {}),
                            ),
                            if (!cartItem.product.isShowCounter)
                              20.horizontalSpace,
                            if (cartItem.product.isShowCounter) Spacer(),
                            GestureDetector(
                              onTap: () {
                                controller.cartService
                                    .removeFromCart(product: cartItem.product);
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
