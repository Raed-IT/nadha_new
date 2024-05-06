import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:delevary/app/Mixins/AddToCartMixin.dart';
import 'package:delevary/app/Services/CartService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/pagination_mixing.dart';

class SearchScreenController extends GetxController with PaginationMixin,AddToCartMixin {
  TextEditingController searchTextController = TextEditingController();
  Rx<String> searchText = Rx("");
  RxInt searchCount = RxInt(0);
  RxInt indexTaps = RxInt(1);
  CartService cartService = CartService();

  Future loadMore() async {
    await getPaginationData(isRefresh: false);
  }

  @override
  void onInit() {
    super.onInit();
    paginationUrl = ApiRoute.search;
  }

  Future search(BuildContext context) async {
    if (searchText.value.isNotEmpty) {
      String type = "";
      if (indexTaps.value == 0) {
        type = "stores";
      } else if (indexTaps.value == 1) {
        type = "products";
      } else if (indexTaps.value == 2) {
        type = "discount";
      }
      paginationParameter = {
        "type": type,
        "search": searchText.value,
      };
      getPaginationData(isRefresh: true);
    } else {
      ToastService.showErrorToast(
          context: context, title: 'الرجاء ملئ حقل البحث');
    }
  }

  @override
  List getModelFromPaginationJsonUsing(Map<String, dynamic> json) {
    List<ProductModel> products = [];
    List<StoreModel> stores = [];
    searchCount.value =
        int.tryParse("${json['data']['pagination']['total']}") ?? 0;
    if (json['data']['type'] == 'stores') {
      for (var store in json['data']['data']) {
        stores.add(StoreModel.fronJson(store));
      }
      return stores;
    } else {
      for (var product in json['data']['data']) {
        products.add(ProductModel.fromJson(product));
      }
      return products;
    }
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']["next_page_url"];
  }
}
