import 'package:delevary/app/Components/StoresList.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:delevary/app/Screens/SearchScreen/SearchScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchStoresListComponent extends GetView<SearchScreenController> {
  const SearchStoresListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (!controller.isLoadPaginationData.value &&
              controller.paginationData.isNotEmpty &&
              controller.paginationData.value.runtimeType == List<StoreModel>)
          ? StoresListComponent(
              stores: controller.paginationData.value as List<StoreModel>,
              isLoad: RxBool(false))
          : Container(),
    );
  }
}
