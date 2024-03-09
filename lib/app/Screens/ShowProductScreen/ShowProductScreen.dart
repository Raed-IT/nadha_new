import 'dart:ui';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductList.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/ShowProductScreen/Components/BottomSheet.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ShowProductScreen extends StatelessWidget {
  const ShowProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowProductScreenController>(
      tag: "show_product${Get.arguments?['product']?.id}",
      builder: (controller) => Builder(
        builder: (context) {
          GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
          GlobalKey productKey = GlobalKey();
          Future.delayed(
            10.ms,
            () => cartKey.currentState!
                .runCartAnimation('${Get.find<MainController>().cart.length}'),
          );
          return controller.buildScaffold(
            cartKey: cartKey,
            scaffold: Scaffold(
              backgroundColor: Colors.transparent,
              bottomSheet: ShowProductBottomSheet(
                cartKey: cartKey,
                controller: controller,
                onAddProduct: (product) {
                  controller.addToCartAnimation(
                      cartKey: cartKey, widgetKey: productKey);
                },
                productList: ProductListComponent(
                  heroTagPrefix: "show${controller.product.value.id}Products",
                  onProductTap: (ProductModel product, key) {
                    Get.toNamed(AppRoutes.showProduct,
                            arguments: {
                              "product": product,
                              "hero":
                                  "show${controller.product.value.id}Products",
                            },
                            preventDuplicates: false)
                        ?.then(
                      (value) => cartKey.currentState!.runCartAnimation(
                          "${Get.find<MainController>().cart.length}"),
                    );
                    Get.put(ShowProductScreenController(),
                        tag: "show_product${product.id}");
                  },
                  products: controller.products,
                  isLoad: controller.isLoad,
                  onTapAddProduct: (ProductModel product, GlobalKey key) {
                    controller.addToCartAnimation(
                        widgetKey: key, cartKey: cartKey);
                    controller.cartService.addToCard(product: product);
                  },
                ),
              ),
              body: GestureDetector(
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: controller.product.value.images!
                              .map(
                                (e) => SizedBox(
                                  height: Get.height,
                                  width: Get.width,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ImageCacheComponent(
                                        width: Get.width,
                                        fit: BoxFit.cover,
                                        image: "${e.url}",
                                      ),
                                      SizedBox(
                                        child: ClipRRect(
                                          // Clip it cleanly.
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 15, sigmaY: 15),
                                            child: Container(
                                              height: Get.height,
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [
                                                  SafeArea(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.sp),
                                                      child: Hero(
                                                        tag:
                                                            "${controller.heroPrefix ?? 'product_image_'}${controller.product.value.id}",
                                                        child: Container(
                                                          key: productKey,
                                                          child:
                                                              ImageCacheComponent(
                                                            height: Get.height *
                                                                0.34,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.sp),
                                                            width: Get.width,
                                                            fit: BoxFit.cover,
                                                            image: "${e.url}",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
