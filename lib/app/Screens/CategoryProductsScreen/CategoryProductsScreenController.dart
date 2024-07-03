import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Mixins/AddToCartMixin.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';

import '../../Services/CartService.dart';

class CategoryProductsScreenController extends GetxController
    with PaginationMixin<ProductModel>, AddToCartMixin {
  CategoryModel category = Get.arguments['category'];
  int? storeId = Get.arguments['store_id'];
  CartService cartService = CartService();

  Future getFreshData({required bool refresh}) async {
    getPaginationData(isRefresh: refresh);
  }

  Future loadMore() async {
    await getPaginationData(isRefresh: false);
  }

  @override
  void onInit() {
    paginationUrl = ApiRoute.products;
    paginationParameter = {"category_id": category.id};
    if (storeId != null) {
      paginationParameter['store_id'] = storeId;
    }
    getFreshData(refresh: true);
    super.onInit();
  }

  @override
  List<ProductModel> getModelFromPaginationJsonUsing(
      Map<String, dynamic> json) {
    List<ProductModel> products = [];
    for (var product in json['data']['products']) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']["next_page_url"];
  }
}
