import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/model/product_model.dart';

class OfferScreenController extends GetxController
    with PaginationMixin<ProductModel> {
   TextEditingController searchController = TextEditingController();
  Map<String, dynamic> search = {
    "search": '',
  };

  @override
  void onInit() {

    isLoadPagination.value = true;
    searchController.addListener(() {
      search['search'] = searchController.text;
    });
    url = ApiRouts.offers;
    getPaginationData(isRefresh: true);
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

  loadParameter() {
    String q = "";
    for (var key in search.keys) {
      q += "$key=${search[key]}&";
    }
    paginationParameter = q;
    getPaginationData(isRefresh: true);
  }
}
