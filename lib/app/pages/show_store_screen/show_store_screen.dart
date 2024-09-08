import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/components/appbar.dart';
import 'package:nadha/app/pages/show_store_screen/show_store_controller.dart';
import 'package:nadha/app/them/app_colors.dart';

import '../components/image_cache_component.dart';
import '../components/products_list_component.dart';

class ShowStoreScreen extends GetView<ShowStoreScreenController> {
  @override
  Widget build(BuildContext context) {
    return controller.buildScreen(
      appBar: SliverPinnedToBoxAdapter(
        child: AppBarComponent(title: "${controller.store.name}"),
      ),
      widgets: [
        SliverToBoxAdapter(
          child: Hero(
            tag: "store_${controller.store.id}",
            child: Card(
              shadowColor: AppColors.highlight.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.sp),
                ),
              ),
              margin: EdgeInsets.all(10.sp),
              elevation: 7,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.sp),
                ),
                child: ImageCacheComponent(
                   width: Get.width,
                  height: 250.h,
                  image: "${controller.store.img}",
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ProductsListComponent(
            isFromStore: true,
            products: controller.paginationData,
            isLoad: controller.isLoadPagination,
          ),
        )
      ],
    );
  }
}
