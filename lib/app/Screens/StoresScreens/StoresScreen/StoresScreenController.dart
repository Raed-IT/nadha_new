import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/pagination_mixing.dart';

class StoresScreenController extends GetxController
    with PaginationMixin<StoreModel> {
  @override
  void onInit() {
    super.onInit();
    paginationUrl = ApiRoute.stores;
    getFreshData();
  }

  void search(data) {
    if (data.isNotEmpty){
      paginationParameter={...paginationParameter,"q":data};
    }
    else{
      paginationParameter.remove("q") ;
    }
  }

  Future getFreshData() async {
    await getPaginationData(isRefresh: true);
  }

  Future loadMore() async {
    await getPaginationData(isRefresh: false);
  }

  @override
  List<StoreModel> getModelFromPaginationJsonUsing(Map<String, dynamic> json) {
    List<StoreModel> stores = [];
    for (var store in json['data']['stores']) {
      stores.add(StoreModel.fromJson(store));
    }
    return stores;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']["next_page_url"];
  }
}
