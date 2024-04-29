import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/pagination_mixing.dart';
import 'package:logger/logger.dart';

class StoreProductsScreenController extends GetxController
    with PaginationMixin<ProductModel> {
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

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']["next_page_url"];
  }
}
