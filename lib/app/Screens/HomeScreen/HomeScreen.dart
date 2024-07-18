import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Components/ProductsComponents/ProductList.dart';
import 'package:delevary/app/Components/TitleSectionComponent.dart';
import 'package:delevary/app/Components/version_dialog.dart';
import 'package:delevary/app/Data/MainController.dart';
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
import '../../Components/CategoriesComponent.dart';
import '../../Components/DrawerComponents/DrawerComponent.dart';
import '../../Components/SlidersComponent.dart';
import 'Components/phoneDialog.dart';

bool isShowVersion = false;
bool isShowPhoneDialog = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    if (Get.find<MainController>().user.value?.phone == null &&
        !isShowPhoneDialog) {
      isShowPhoneDialog = true;
      showPhoneDialog(context);
    }
    if (!isShowVersion &&
        Get.find<MainController>().packageInfo.version !=
            Get.find<MainController>().setting.value!.currentVersion) {
      isShowVersion = true;
      showVersionDialog(context);
    }
    if (!Get.isRegistered<HomeScreenController>()) {
      Get.put(HomeScreenController());
    }

    ScrollController scrollController = ScrollController();
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        Get.find<MainScaffoldScreenController>().isScrollUp.listen((p0) {
          if (scrollController.hasClients) {
            if (scrollController.position.pixels != 0) {
              scrollController.animateTo(
                0,
                duration: 100.ms,
                curve: Curves.decelerate,
              );
            } else {
              scrollController.animateTo(
                -800.h,
                duration: 1000.ms,
                curve: Curves.decelerate,
              );
              Future.delayed(
                800.ms,
                () => controller.getFreshData(refresh: true),
              );
            }
          }
        });
        return Scaffold(
          drawerEnableOpenDragGesture: false,
          drawer: const DrawerComponent(),
          body: Builder(
            builder: (context) => Container(
              height: Get.height,
              color: Theme.of(context).colorScheme.background,
              child: Column(
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
                          autoPlay: true,
                          height: Get.width,
                          sliders: controller.sliders,
                          controller: PageController(),
                          isLoad: controller.isLoad,
                        ),
                        Obx(
                          () => Column(
                            children: [
                              if (!controller.isLoad.value) 20.verticalSpace,
                              BuildTitleSectionComponent(
                                // padding:
                                // EdgeInsets.symmetric(horizontal: 10.sp),
                                title: "الفئات ",
                                isLoad: controller.isLoad,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          child: CategoriesComponent(
                            categories: controller.categories,
                            isLoading: controller.isLoad,
                          ),
                        ),
                        BuildTitleSectionComponent(
                          title: "المنتجات الرائجة",
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
                            Get.put(
                              ShowProductScreenController(),
                              tag: "show_product${product.id}",
                            );
                          },
                          isLoad: controller.isLoadPaginationData,
                          onTapAddProduct: (product, productKy) {
                            Get.find<MainScaffoldScreenController>()
                                .addToCart(product, productKy, onSetState: () {
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
                        await controller.getFreshData(refresh: true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
