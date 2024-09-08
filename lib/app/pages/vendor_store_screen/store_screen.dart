import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/pages/components/appbar.dart';
import 'package:nadha/app/pages/components/products_list_component.dart';
import 'package:nadha/app/pages/vendor_store_screen/store_controller.dart';

class StoreScreen extends GetView<StoreScreenController> {
  @override
  Widget build(BuildContext context) {
    return controller.buildScreen(
      widgets: [
        SliverToBoxAdapter(
          child: ProductsListComponent(
            onRefresh: () {
              controller.getPaginationData(isRefresh: true);
            },
            products: controller.paginationData,
            isLoad: controller.isLoadPagination,
          ),
        ),
      ],
      appBar: const SliverPinnedToBoxAdapter(
        child: AppBarComponent(
          title: "متجري",
        ),
      ),
    );
  }
}
