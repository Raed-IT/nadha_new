import 'dart:async';

import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';

import '../../Data/ApiRoute.dart';
import '../../Data/Models/ProductModel.dart';

class SaleScreenController extends GetxController
    with PaginationMixin<ProductModel> {
  @override
  void onInit() {
    paginationUrl = "${ApiRoute.products}-sale";
    getFreshData();
    super.onInit();
  }
Future<void> search(data)async{
  if (data.isNotEmpty){
    paginationParameter={...paginationParameter,"q":data};
  }
  else{
    paginationParameter.remove("q") ;
  }
}

Future<void> getFreshData ()async{
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
