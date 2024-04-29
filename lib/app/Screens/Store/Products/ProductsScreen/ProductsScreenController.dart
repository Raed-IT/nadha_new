import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';

class StoreProductsScreenController extends GetxController
    with PaginationMixin<ProductModel>, ApiHelperMixin {
  @override
  void onInit() {
    super.onInit();
    paginationParameter = {
      "type": 'products',
      "store_id": Get.find<MainController>().user.value?.store?.id
    };
    paginationUrl = ApiRoute.MyStores;
    getDataFromApi();
  }

  Future getDataFromApi() async {
    await getPaginationData(isRefresh: true);
  }

  Future loadMore() async {
    await getPaginationData(isRefresh: false);
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

  Future<bool> changeProductStatus(ProductModel product, bool status) async {
    bool status = false;
    await postData(
        url: "${ApiRoute.products}/${product.id}",
        data: {},
        onSuccess: (data, t) {
          if (data.data['status'] == "SUCCESS") {
            status = true;
          }
        },
        onError: (e, t) {});
    return status;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']["next_page_url"];
  }
}
