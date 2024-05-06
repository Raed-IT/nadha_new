import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Components/ProductsComponents/EmptyProductComponent.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Screens/SearchScreen/Components/LoaderSearchComponent.dart';
import 'package:delevary/app/Screens/SearchScreen/Components/SearchFieldComponent.dart';
import 'package:delevary/app/Screens/SearchScreen/Components/SearchProductListComponent.dart';
import 'package:delevary/app/Screens/SearchScreen/Components/SearchStoresListComponent.dart';
import 'package:delevary/app/Screens/SearchScreen/Components/TapsComponents.dart';
import 'package:delevary/app/Screens/SearchScreen/SearchScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Route/Routs.dart';

class SearchScreen extends GetView<SearchScreenController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();

    ScrollController scrollController = ScrollController();
    return controller.buildScaffold(
      scaffold: Scaffold(
        floatingActionButton: AddToCartIcon(
          key: cartKey,
          badgeOptions:
              BadgeOptions(active: Get.find<MainController>().cart.isNotEmpty),
          icon: SizedBox(
            height: 50.sp,
            width: 50.sp,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000.sp),
              ),
              child: Center(
                child: Lottie.asset("assets/json/cart.json",
                    width: 30.w, repeat: false),
              ),
              onPressed: () => Get.toNamed(AppRoutes.cartScreen),
              //params
            ),
          ),
        ),
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
                      begin: const Offset(20, 20),
                      duration: const Duration(seconds: 1),
                    ),
                SafeArea(
                  child: Column(
                    children: [
                      10.verticalSpace,
                      const SearchFieldComponent(),
                      10.verticalSpace,
                      Obx(() => (!controller.isLoadPaginationData.value &&
                              controller.searchCount.value > 0)
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50.sp)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.sp, vertical: 3.sp),
                                child: Text(
                                    "${controller.searchCount.value}  نتيجة بحث"),
                              ),
                            )
                          : Container()),
                      10.verticalSpace,
                      const TapsSearchComponent(),
                      Expanded(
                          child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(0),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          LoaderSearchComponent(),
                          SearchProductListComponent((ky, pro) {
                            controller.cartService.addToCard(
                              product: pro,
                              context: context,
                              onAddAnimation: (k, isAnimation) {
                                if (isAnimation) {
                                  controller.addToCartAnimation(
                                      widgetKey: k, cartKey: cartKey);
                                }
                              },
                            );
                          }),
                          SearchStoresListComponent(),
                          Obx(() => !controller.isLoadPaginationData.value &&
                                  controller.paginationData.isEmpty
                              ? EmptyProductComponent()
                              : Container()),
                          LoadMoreComponent(
                            isFinished: controller.isFinish,
                            isLoad: controller.isLoadMore,
                          )
                        ],
                      ).loadMoreAble(
                        scrollController: scrollController,
                        onLoadMore: () async {
                          await controller.loadMore();
                        },
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      cartKey: cartKey,
    );
  }
}
