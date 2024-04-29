import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Products/ProductsScreen/Components/BuildProductsListStoreCardComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../Components/AppBarComponents/AppBarComponent.dart';
import '../../../../Components/DrawerComponents/DrawerComponent.dart';
import 'ProductsScreenController.dart';

class StoreProductsScreen extends GetView<StoreProductsScreenController> {
  const StoreProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic product = await Get.toNamed(AppRoutes.addProduct);
          if (product != null) {
            controller.paginationData.insert(0, product);
          }
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          FontAwesomeIcons.plus,
          size: 20.sp,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
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
                    title: "منتجات متجري",
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
                        BuildProductsListStoreComponent(
                          onChangeStatus:
                              (ProductModel product, bool status) async {
                            return await controller.changeProductStatus(
                                product, status);
                          },
                          onDeleteProduct: (ProductModel product) async {
                            await controller.deleteProduct(context, product);
                          },
                        ),
                        LoadMoreComponent(
                          isFinished: controller.isFinish,
                          isLoad: controller.isLoadMore,
                        )
                      ],
                    ).refreshAbel(onRefresh: () async {
                      await controller.getDataFromApi();
                    }).loadMoreAble(
                        scrollController: scrollController,
                        onLoadMore: () async {
                          await controller.loadMore();
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
