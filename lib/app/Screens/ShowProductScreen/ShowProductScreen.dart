import 'dart:ui';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/DrawerComponents/DrawerComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/AddToCartComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/BuildPrice.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductList.dart';
 import 'package:delevary/app/Components/TitleSectionComponent.dart';
 import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
 import 'package:delevary/app/Route/Routs.dart';
 import 'package:delevary/app/Screens/ShowProductScreen/Components/ImageShowProductComonent.dart';
import 'package:delevary/app/Screens/ShowProductScreen/Components/StoreProductComponent.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:get/get.dart';
 import 'package:lottie/lottie.dart';

class ShowProductScreen extends StatefulWidget {
  const ShowProductScreen({super.key});

  @override
  State<ShowProductScreen> createState() => _ShowProductScreenState();
}

class _ShowProductScreenState extends State<ShowProductScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowProductScreenController>(
      tag:
          "show_product${(Get.arguments?.containsKey('product') ?? false) ? Get.arguments['product']?.id : ''}",
      builder: (controller) => Builder(
        builder: (context) {
          GlobalKey productKey = GlobalKey();
          GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
          Future.delayed(
            10.ms,
            () => cartKey.currentState!
                .runCartAnimation('${Get.find<MainController>().cart.length}'),
          );
          return controller.buildScaffold(
            cartKey: cartKey,
            scaffold: Scaffold(
              drawer: const DrawerComponent(),
              floatingActionButton: AddToCartIcon(
                key: cartKey,
                badgeOptions: BadgeOptions(
                    active: Get.find<MainController>().cart.isNotEmpty),
                icon: SizedBox(
                  height: 50.sp,
                  width: 50.sp,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000.sp),
                    ),
                    child: Center(
                        child: Lottie.asset("assets/json/cart.json",
                            width: 30.w, repeat: false)),
                    onPressed: () => Get.toNamed(AppRoutes.cartScreen),
                    //params
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              body: Builder(builder: (context) {
                return Stack(
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
                          delay: const Duration(milliseconds: 500),
                          begin: const Offset(20, 20),
                          duration: const Duration(seconds: 2),
                        ),
                    Column(
                      children: [
                        AppBarComponent(
                          title: "عرض منتج",
                          openDrawer: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(0),
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Obx(
                                () => controller.isLoad.value &&
                                        controller.productSlug != null
                                    ? SizedBox(
                                        height: 400.h,
                                        width: Get.width,
                                        child: Center(
                                          child: Lottie.asset(
                                              'assets/json/loader.json',
                                              width: 250.w),
                                        ),
                                      )
                                    : (controller.product.value == null)
                                        ? SizedBox(
                                            height: 300.h,
                                            width: Get.width,
                                            child: Center(
                                              child: Text(
                                                  "لم يتم العثور على المنتج "),
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              ImageShowProductComponent(
                                                productKey: productKey,
                                              ),
                                              SizedBox(
                                                  width: Get.width,
                                                  height: 100,
                                                  child:
                                                      StoreProductComponent()),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10.sp),
                                                child: BlurryContainer(
                                                  blur: 7,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${controller.product.value?.name}",
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15.sp,
                                                        ),
                                                        softWrap: true,
                                                      ),
                                                      Text(
                                                        "${controller.product.value?.info}",
                                                        softWrap: true,
                                                      ),
                                                      20.verticalSpace,
                                                      BuildPriceProductComponent(
                                                        size: 18.sp,
                                                        product: Rx(controller
                                                            .product.value!),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              10.verticalSpace,
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.sp,
                                                ),
                                                child: AddToCardComponent(
                                                  onAddAnimation: (k) {
                                                    controller
                                                        .addToCartAnimation(
                                                            cartKey: cartKey,
                                                            widgetKey: k);
                                                    cartKey.currentState!
                                                        .runCartAnimation(
                                                            '${Get.find<MainController>().cart.length}');
                                                  },
                                                  product:
                                                      controller.product.value!,
                                                  onAddProduct: (prod) {
                                                    if (prod.unit ==
                                                        ProductUnitTypeEnum
                                                            .piece) {
                                                      controller
                                                          .addToCartAnimation(
                                                              cartKey: cartKey,
                                                              widgetKey:
                                                                  productKey);
                                                      cartKey.currentState!
                                                          .runCartAnimation(
                                                              '${Get.find<MainController>().cart.length}');
                                                    }
                                                  },
                                                ),
                                              ),
                                              40.verticalSpace,
                                              BuildTitleSectionComponent(
                                                isLoad: RxBool(false),
                                                title: "منتجات ذات صلة",
                                              ),
                                              20.verticalSpace,
                                            ],
                                          ),
                              ),
                              ProductListComponent(
                                heroTagPrefix:
                                    "show${controller.product.value?.id}Products",
                                products: controller.products,
                                onProductTap: (ProductModel product, k) {
                                  if (product.id !=
                                      controller.product.value?.id) {
                                    Get.toNamed(AppRoutes.showProduct,
                                        preventDuplicates: false,
                                        arguments: {
                                          "store": controller.store,
                                          "product": product,
                                          "hero":
                                              "show${controller.product.value?.id}Products",
                                        });
                                    Get.put(
                                      ShowProductScreenController(),
                                      tag: "show_product${product.id}",
                                    );
                                  }
                                },
                                isLoad: controller.isLoad,
                                onTapAddProduct:
                                    (ProductModel product, GlobalKey key) {
                                  controller.addToCartAnimation(
                                      widgetKey: key, cartKey: cartKey);
                                  controller.cartService.addToCard(
                                      product: product, context: context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Get.find<MainController>().cart.listen((p0) {
      if (mounted) {
        setState(() {});
      }
    });
  }
}
