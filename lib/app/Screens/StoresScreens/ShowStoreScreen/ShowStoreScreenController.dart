import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Data/Models/SliderModel.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:delevary/app/Mixins/AddToCartMixin.dart';
import 'package:delevary/app/Services/CartService.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';
import 'package:logger/logger.dart';

class ShowStoreScreenController extends GetxController
    with ApiHelperMixin, PaginationMixin<ProductModel>, AddToCartMixin {
  Rxn<StoreModel> store = Rxn(Get.arguments['store']);
  RxList<CategoryModel> categories = RxList([]);
  RxList<SliderModel> sliders = RxList([]);
  CartService cartService = CartService();
  String? storeId = "${Get.arguments['store_id']}";

  @override
  void onInit() {
    super.onInit();
    if (storeId != "null" && store.value == null) {
      // Logger().w(storeId);
      getSingleData(
        url:
            UrlModel(url: "${ApiRoute.stores}/show/$storeId", type: "getStore"),
      );
    }
    if (store.value != null && storeId == 'null') {
      initData();
    }
  }

  void initData() {
    paginationUrl = ApiRoute.products;
    paginationParameter = {
      "store_id": store.value!.id,
    };
   getFreshData();
  }

  Future getFreshData() async {
    getSingleData(
        url: UrlModel(
            url: "${ApiRoute.stores}/${store.value!.id}", type: "store_show"));
    await getPaginationData(isRefresh: true);
  }

  Future loadMore() async {
    await getPaginationData(isRefresh: false);
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    if (type != "getStore") {
      categories.clear();
      sliders.clear();
      for (var slider in json['data']['sliders']) {
        sliders.add(SliderModel.fromJson(slider));
      }
      for (var category in json['data']['categories']) {
        categories.add(CategoryModel.fromJson(category));
      }
    } else {
      if (json['status'] == "ERROR") {
        Fluttertoast.showToast(msg: "خطأ لم يتم العثور على المتجر");
        Get.back();
        return;
      }
      store.value = StoreModel.fronJson(json['data']['store']);
      initData();
    }
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
