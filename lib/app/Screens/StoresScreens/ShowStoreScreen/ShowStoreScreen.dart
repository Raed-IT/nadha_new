import 'dart:ffi';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:delevary/app/Components/GridCardComponent.dart';
import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductList.dart';
import 'package:delevary/app/Components/SlidersComponent.dart';
import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/SearchScreen/Components/LoaderSearchComponent.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:delevary/app/Screens/StoresScreens/ShowStoreScreen/ShowStoreScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../../Components/AppBarComponents/AppBarComponent.dart';
import '../../../Components/DrawerComponents/DrawerComponent.dart';
import '../../../Components/TitleSectionComponent.dart';
import 'package:share_plus/share_plus.dart';

class ShowStoreScreen extends StatefulWidget {
  const ShowStoreScreen({super.key});

  @override
  State<ShowStoreScreen> createState() => _ShowStoreScreenState();
}

class _ShowStoreScreenState extends State<ShowStoreScreen> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();

  @override
  void initState() {
    super.initState();
    Get.find<MainController>().cart.listen(
      (p0) {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      10.ms,
      () => cartKey.currentState!
          .runCartAnimation('${Get.find<MainController>().cart.length}'),
    );
    ScrollController scrollController = ScrollController();
    return GetBuilder<ShowStoreScreenController>(builder: (controller) {
      return controller.buildScaffold(
        cartKey: cartKey,
        scaffold: Scaffold(
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000.sp),
                ),
                child: Center(
                  child: Icon(FontAwesomeIcons.shareNodes),
                ),
                onPressed: () {
                  Share.share(
                      '${controller.store.value?.name}\n\n\n${ApiRoute.domin}/stores/${controller.store.value?.uniqName}');
                },
              ),
              10.verticalSpace,
              AddToCartIcon(
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
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                        delay: const Duration(milliseconds: 500),
                        begin: const Offset(20, 20),
                        duration: const Duration(seconds: 2),
                      ),
                  Obx(
                    () => ((controller.isLodData.value['getStore']?.value ??
                                true) &&
                            controller.store.value != null)
                        ? Column(
                            children: [
                              AppBarComponent(
                                title: "${controller.store.value!.name}",
                                openDrawer: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              ),
                              Expanded(
                                child: ListView(
                                  controller: scrollController,
                                  padding: const EdgeInsets.all(0),
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    SliderComponent(
                                      sliders: controller.sliders,
                                      controller: PageController(),
                                      isLoad: controller.isLoad,
                                    ),
                                    10.verticalSpace,
                                    BuildTitleSectionComponent(
                                      title: "الفئات الرئيسية",
                                      isLoad: controller.isLoad,
                                    ),
                                    20.verticalSpace,
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.sp),
                                      child: GridListComponent<CategoryModel>(
                                        prifexHero: "categories",
                                        items: controller.categories,
                                        isLoad: controller.isLoad,
                                        onTap: (CategoryModel item) {
                                          Get.toNamed(
                                              AppRoutes.categoryProducts,
                                              arguments: {
                                                "category": item,
                                                "store_id":
                                                    controller.store.value!.id
                                              });
                                        },
                                      ),
                                    ),
                                    10.verticalSpace,
                                    BuildTitleSectionComponent(
                                      title: "المنتجات الاكثر طلب",
                                      isLoad: controller.isLoad,
                                    ),
                                    5.verticalSpace,
                                    ProductListComponent(
                                      heroTagPrefix: "homeProducts",
                                      products: controller.paginationData,
                                      onProductTap: (ProductModel product, k) {
                                        Get.toNamed(AppRoutes.showProduct,
                                            preventDuplicates: false,
                                            arguments: {
                                              "store": controller.store.value,
                                              "product": product,
                                              "hero": "homeProducts"
                                            });
                                        Get.put(ShowProductScreenController(),
                                            tag: "show_product${product.id}");
                                      },
                                      isLoad: controller.isLoadPaginationData,
                                      onTapAddProduct: (product, productKey) {
                                        controller.addToCartAnimation(
                                            cartKey: cartKey,
                                            widgetKey: productKey);
                                        controller.cartService
                                            .addToCard(product: product);
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
                                    await controller.getFreshData();
                                  },
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Lottie.asset('assets/json/loader.json',
                                width: 200.w, height: 200.h),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
