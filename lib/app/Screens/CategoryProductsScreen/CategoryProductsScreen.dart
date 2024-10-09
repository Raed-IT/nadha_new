import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/AppBarComponents/v2/appBar/appbar_with_title.dart';
import 'package:delevary/app/Components/ChachImageComponent.dart';
import 'package:delevary/app/Components/DrawerComponents/DrawerComponent.dart';
import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductList.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/CategoryProductsScreen/CategoryProductsScreenController.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Components/AppBarComponents/AppBarComponent.dart';

class CategoryProductsScreen extends GetView<CategoryProductsScreenController> {
  const CategoryProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
    Future.delayed(
      10.ms,
      () => cartKey.currentState!
          .runCartAnimation('${Get.find<MainController>().cart.length}'),
    );
    ScrollController scrollController = ScrollController();
    return controller.buildScaffold(
      cartKey: cartKey,
      scaffold: Scaffold(
        floatingActionButton: SizedBox(
          width: 50.sp,
          height: 50.sp,
          child: AddToCartIcon(
            key: cartKey,
            badgeOptions: BadgeOptions(
                active: Get.find<MainController>().cart.isNotEmpty),
            icon: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000.sp),
              ),
              child: Center(
                child: Lottie.asset(
                  "assets/json/cart.json",
                  width: 30.w,
                  reverse: true,
                ),
              ),
              onPressed: () => Get.toNamed(AppRoutes.cartScreen),
              //params
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        drawer: const DrawerComponent(),
        body: Builder(
          builder: (context) => Container(
            height: Get.height,
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                AppBarWithTitleComponent(title: "${controller.category.name}"),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(0),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ProductListComponent(
                        title: "المنتجات الأكثر طلبا ",
                        heroTagPrefix: "categories",
                        products: controller.paginationData,
                        onProductTap: (ProductModel product, k) {
                          Get.toNamed(AppRoutes.showProduct,
                              preventDuplicates: false,
                              arguments: {
                                "product": product,
                                "hero": "categories"
                              });
                          Get.put(
                            ShowProductScreenController(),
                            tag: "show_product${product.id}",
                          );
                        },
                        isLoad: controller.isLoadPaginationData,
                        onTapAddProduct: (ProductModel product, GlobalKey key) {
                          controller.cartService.addToCard(
                              product: product,
                              context: context,
                              onAddAnimation: (k, isAdd) {
                                if (isAdd) {
                                  controller.addToCartAnimation(
                                      widgetKey: k, cartKey: cartKey);
                                }
                              });
                        },
                      ),
                      LoadMoreComponent(
                        isFinished: controller.isFinish,
                        isLoad: controller.isLoadMore,
                      )
                    ],
                  )
                      .loadMoreAble(
                    scrollController: scrollController,
                    onLoadMore: () async {
                      await controller.loadMore();
                    },
                  )
                      .refreshAbel(
                    onRefresh: () async {
                      await controller.getFreshData(refresh: true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
