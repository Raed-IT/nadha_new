import 'package:add_to_cart_animation/globalkeyext.dart';
import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Components/GridCardComponent.dart';
import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductList.dart';
import 'package:delevary/app/Components/TitleSectionComponent.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/HomeScreen/HomeScreenController.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenController.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../Components/DrawerComponents/DrawerComponent.dart';
import '../../Components/SlidersComponent.dart';
import '../CategoriesScreen/CategoriesScreenController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // if (!controller.isLoad.value) {
    //   controller.isLoad.value = true;
    // }
    if (!Get.isRegistered<HomeScreenController>()) {
      Get.put(HomeScreenController());
    }
    ScrollController scrollController = ScrollController();
    return GetBuilder<HomeScreenController>(
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
                      delay: const Duration(milliseconds: 500),
                      begin: const Offset(20, 20),
                      duration: const Duration(seconds: 2),
                    ),
                Column(
                  children: [
                    AppBarComponent(
                      showLogo: true,
                      showSearch: true,
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
                          Obx(
                            () => Column(
                              children: [
                                if (!controller.isLoad.value) 10.verticalSpace,
                                BuildTitleSectionComponent(
                                  title: "الفئات الرئيسية",
                                  isLoad: controller.isLoad,
                                ),
                                if (!controller.isLoad.value) 20.verticalSpace,
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.sp),
                            child: GridListComponent<CategoryModel>(
                              prifexHero: "categories",
                              items: controller.categories,
                              isLoad: controller.isLoad,
                              onTap: (CategoryModel item) {
                                if (item.hasChildren!) {
                                  Get.toNamed(
                                    AppRoutes.categories,
                                    arguments: {
                                      "category": item,
                                    },
                                  );
                                  Get.put(CategoriesScreenController(),
                                      tag: "category${item.id}");
                                } else {
                                  Get.toNamed(AppRoutes.categoryProducts,
                                      arguments: {"category": item});
                                }
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
                                    "product": product,
                                    "hero": "homeProducts"
                                  });
                              Get.put(ShowProductScreenController(),
                                  tag: "show_product${product.id}");
                            },
                            isLoad: controller.isLoadPaginationData,
                            onTapAddProduct: (product, productKy) {
                              Get.find<MainScaffoldScreenController>()
                                  .addToCart(product, productKy,
                                      onSetState: () {
                                setState(() {});
                              }, context: context);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
