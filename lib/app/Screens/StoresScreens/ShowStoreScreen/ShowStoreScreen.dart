
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductList.dart';
 import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:delevary/app/Screens/StoresScreens/ShowStoreScreen/ShowStoreScreenController.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Obx(() => (controller.store.value != null)
              ? Column(
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
                )
              : Container()),
          drawerEnableOpenDragGesture: false,
          drawer: const DrawerComponent(),
          body: Builder(
            builder: (context) => Container(
              height: Get.height,
              color: Theme.of(context).colorScheme.background,
              child: Obx(
                () => (controller.isLoad.value)
                    ? Center(
                        child: Lottie.asset('assets/json/loader.json',
                            width: 200.w, height: 200.h),
                      )
                    : (controller.store.value != null)
                        ? Column(
                            children: [
                              AppBarComponent(
                                showLogo: false,
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
                                    Padding(
                                        padding: EdgeInsets.all(20.sp),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                controller.store.value?.image ??
                                                    '',
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.all(20.sp),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.mapMarkerAlt,
                                                size: 15.sp,
                                                color: AppColors.highLightColor,
                                              ),
                                              10.horizontalSpace,
                                              Expanded(
                                                child: Text(
                                                    controller.store.value?.address ?? '----'),
                                              ),
                                            ],
                                          ),
                                          10.verticalSpace,
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.clock,
                                                size: 15.sp,
                                                color: AppColors.highLightColor,
                                              ),
                                              10.horizontalSpace,
                                              Text(
                                                "اوقات الدوام :  ${controller.store.value?.openAt} - ${controller.store.value?.closeAt}",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .highLightColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11.sp),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                      child: Text("منتجات المتجر ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp),),
                                    ),
                                    10.verticalSpace,
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
                                        controller.cartService.addToCard(
                                            product: product, context: context);
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
                        : SizedBox(
                            height: Get.height,
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset("assets/json/stores.json",
                                    width: 500.sp,
                                    height: 400.sp,
                                    alignment: Alignment.center,
                                    fit: BoxFit.fill),
                                Transform.translate(
                                  offset: Offset(0, -80.h),
                                  child: GestureDetector(
                                    onTap: () => Get.back(),
                                    child: Text(
                                      ' لم يتم العثور على المتجر\n انقر للعودة الى الصفحة الرئيسية',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
