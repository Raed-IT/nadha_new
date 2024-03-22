import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/SearchScreen/SearchScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Components/ProductsComponents/ProductList.dart';
import '../../ShowProductScreen/ShowProductScreenController.dart';

class SearchProductListComponent extends GetView<SearchScreenController> {
  const SearchProductListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => (!controller.isLoadPaginationData.value &&
            controller.paginationData.isNotEmpty &&
            controller.paginationData.value.runtimeType == List<ProductModel>)
        ? ProductListComponent(
            products: controller.paginationData.value as List<ProductModel>,
            heroTagPrefix: "search",
            onProductTap: (ProductModel product, k) {
              Get.toNamed(AppRoutes.showProduct,
                  preventDuplicates: false,
                  arguments: {"product": product, "hero": "search"});
              Get.put(ShowProductScreenController(),
                  tag: "show_product${product.id}");
            },
            isLoad: RxBool(false),
            onTapAddProduct: (product, key) {},
          )
        : Container());
  }
}
