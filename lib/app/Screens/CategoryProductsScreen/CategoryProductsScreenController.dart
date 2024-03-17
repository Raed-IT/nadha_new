import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';

class CategoryProductsScreenController extends GetxController
    with PaginationMixin<ProductModel> {
  CategoryModel category = Get.arguments['category'];

  Future getFreshData() async {
    getPaginationData(isRefresh: true);
  }

  Future loadMore() async {
    await getPaginationData(isRefresh: false);
  }

  @override
  void onInit() {
    paginationUrl = ApiRoute.products;
    paginationParameter = {"category_id": category.id};
    getFreshData();
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
