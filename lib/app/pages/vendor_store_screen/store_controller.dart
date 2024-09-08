import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/product_model.dart';

class StoreScreenController extends GetxController
    with PaginationMixin<ProductModel> {
  @override
  void onInit() {
    isLoadPagination.value = true;
    paginationParameter =
        "store_id=${Get.find<MainController>().user.value?.id}";
    getPaginationData(isRefresh: true);
    url = ApiRouts.products;
    super.onInit();
  }

  @override
  String? getNextUrlForPaginationUsing(Map<String, dynamic> data) {
    return data["data"]["nextPage"];
  }

  @override
  List<ProductModel> getModelFromPaginationJsonUsing(
      Map<String, dynamic> json) {
    List<ProductModel> products = [];
    for (var product in json['data']["products"]) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }
}
