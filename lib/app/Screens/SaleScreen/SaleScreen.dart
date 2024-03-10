import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Screens/SaleScreen/SaleScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../Components/DrawerComponents/DrawerComponent.dart';
import '../../Components/ProductsComponents/ProductList.dart';
import '../../Data/Models/ProductModel.dart';
import '../../Route/Routs.dart';
import '../MainScaffoldSreen/MainScaffoldScreenController.dart';
import '../ShowProductScreen/ShowProductScreenController.dart';

class SaleScreen extends GetView<SaleScreenController> {
  const SaleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    controller.getDataFromApi();
    return Scaffold(
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
                      padding: const EdgeInsets.all(0),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ProductListComponent(
                          onRemoveProductFromFavorite: (product) {
                            controller.products.remove(product);
                          },
                          heroTagPrefix: "favoriteProducts",
                          products: controller.products,
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
                          isLoad: controller.isLoad,
                          onTapAddProduct:
                          Get.find<MainScaffoldScreenController>()
                              .addToCart,
                        )
                      ],
                    ),
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
