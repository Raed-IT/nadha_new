import 'dart:ui';

import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductList.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/ShowProductScreen/Components/BottomSheet.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../Components/AppBarComponents/BackAppBar.dart';

class ShowProductScreen extends StatelessWidget {
  const ShowProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: GetBuilder<ShowProductScreenController>(
        tag: "${Get.arguments?['product']?.id}",
        builder: (controller) => Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              showProductDetailsBottomSheet(
                productList: ProductListComponent(
                  onProductTap: (ProductModel product) {
                    Logger().w(product);
                    Get.toNamed(AppRoutes.showProduct,
                        arguments: {"product": product},
                        preventDuplicates: true);
                    Get.put(ShowProductScreenController(),
                        tag: "show_product${product.id}");
                  },
                  products: controller.products,
                  isLoad: controller.isLoad,
                ),
                product: controller.product,
                context: context,
              );
            },
          );
          return Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: controller.product.value.images!
                            .map((e) => SizedBox(
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
                                                            "product_image_${controller.product.value.id}",
                                                        child:
                                                            ImageCacheComponent(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.sp),
                                                          width: Get.width,
                                                          fit: BoxFit.fitHeight,
                                                          image: "${e.url}",
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
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const BackAppBarComponent(),
            ],
          );
        }),
      ),
    );
  }
}
