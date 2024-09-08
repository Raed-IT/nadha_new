import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/model/store_model.dart';

class StoresScreenController extends GetxController
    with PaginationMixin<StoreModel> {
  TextEditingController searchController = TextEditingController();

  Map<String, dynamic> search = {
    "search": '',
  };

  loadParameter() {
    String q = "";
    for (var key in search.keys) {
      q += "$key=${search[key]}&";
    }
    Logger().w(q);
    paginationParameter = q;
    getPaginationData(isRefresh: true);
  }

  @override
  void onInit() {
    isLoadPagination.value = true;
    url = ApiRouts.vendors;
    searchController.addListener(() {
      search['search'] = searchController.text;
    });
    getPaginationData(isRefresh: true);
    super.onInit();
  }

  @override
  String? getNextUrlForPaginationUsing(Map<String, dynamic> data) {
    return data['data']['nextPage'];
  }

  @override
  List<StoreModel> getModelFromPaginationJsonUsing(Map<String, dynamic> json) {
    // Logger().w(json['data']);
    List<StoreModel> stores = [];
    for (var item in json['data']['stores']) {
      stores.add(StoreModel.fromJson(item));
    }
    return stores;
  }
}
