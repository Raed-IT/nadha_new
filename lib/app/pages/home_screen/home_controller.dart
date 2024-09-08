import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helper_plugin/helper.dart';
import 'package:helper_plugin/utilitis/url_model.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/option_model.dart';
import 'package:nadha/app/data/model/product_model.dart';
import '../../data/model/category_model.dart';
import '../../data/model/slider_model.dart';

class HomeScreenController extends GetxController
    with PaginationMixin<ProductModel>, ApiHelperMixin {
  TextEditingController searchController = TextEditingController();
  RxList<CategoryModel> categories = RxList([]);
  Rxn<CategoryModel> selectedCategory = Rxn();
  RxList<SliderModel> sliders = RxList([]);
  Map<String, dynamic> search = {
    "category_id": "",
    "search": '',
    "store_id": "",
  };

  @override
  void onInit() {
    Get.find<MainController>().isActiveStore.value =
        Get.find<MainController>().user.value!.isClose!;
    scrollController = ScrollController();
    searchController.addListener(() {
      search['search'] = searchController.text;
    });
    urlsGetRequest = [UrlModel(url: ApiRouts.categories, type: "category")];
    selectedCategory.listen(
      (p0) {
        if (p0 != null) {
          search['category_id'] = p0.id!;
        } else {
          search['category_id'] = "";
        }
        loadParameter();
      },
    );
    getData();
    isLoadPagination.value = true;
    url = ApiRouts.products;
    getPaginationData(isRefresh: true);
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
    Get.find<MainController>().option.value =
        OptionModel.fromJson(json['data']['option']);
    for (var product in json['data']["products"]) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }

  @override
  void getModelFromJsonUsing(json, String urlType) {
    if (urlType == "category") {
      for (var slider in json['data']['sliders']) {
        sliders.add(SliderModel.fromJson(slider));
      }
      for (var category in json['data']['categories']) {
        categories.add(CategoryModel.fromJson(category));
      }
    }
  }

  loadParameter() {
    String q = "";
    for (var key in search.keys) {
      q += "$key=${search[key]}&";
    }
    paginationParameter = q;
    getPaginationData(isRefresh: true);
  }
}
