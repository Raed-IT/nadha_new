import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/option_model.dart';
import 'package:nadha/app/data/model/product_model.dart';
import 'package:nadha/app/data/model/store_model.dart';

class ShowStoreScreenController extends GetxController
    with PaginationMixin<ProductModel> {
  StoreModel store = Get.arguments['store'];

  @override
  void onInit() {
    isLoadPagination.value = true;
    url = ApiRouts.products;
    paginationParameter = "store_id=${store.id}";
    getPaginationData(isRefresh: true);
    super.onInit();
  }

  @override
  List<ProductModel> getModelFromPaginationJsonUsing(
      Map<String, dynamic> json) {
    List<ProductModel> products = [];
    Get.find<MainController>().option.value =
        OptionModel.fromJson(json['data']['option']);
    for (var product in json['data']['products']) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }
}
