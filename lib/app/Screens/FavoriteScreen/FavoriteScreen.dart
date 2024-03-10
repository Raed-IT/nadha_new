import 'package:delevary/app/Components/ProductsComponents/ProductList.dart';
import 'package:delevary/app/Components/TitleSectionComponent.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Screens/FavoriteScreen/FavoriteScreenController.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../Components/AppBarComponents/AppBarComponent.dart';
import '../../Components/DrawerComponents/DrawerComponent.dart';
import '../../Route/Routs.dart';
import '../ShowProductScreen/ShowProductScreenController.dart';

class FavoriteScreen extends GetView<FavoriteScreenController> {
  const FavoriteScreen({super.key});

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
                        BuildTitleSectionComponent(
                            isLoad: controller.isLoad,
                            title: "المنتجات المفضلة لديك"),
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
