import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nadha/app/data/model/store_model.dart';
import 'package:nadha/app/pages/stores_screen/stores_controller.dart';
import 'package:nadha/app/route/routs.dart';
import 'package:nadha/app/them/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/appbar.dart';
import '../components/bottom_nav_component.dart';
import '../components/image_cache_component.dart';

class StoresScreen extends GetView<StoresScreenController> {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.buildScreen(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      bottomNavigationBar: const BottomNavComponent(),
      appBar: Builder(builder: (context) {
        return SliverPinnedToBoxAdapter(
          child: AppBarComponent(
            onClearSearch: () {
              controller.search['search'] = "";
              controller.loadParameter();
            },
            onSearchEditingComplete: (data) {
              controller.loadParameter();
            },
            searchController: controller.searchController,
            onOpenDrawer: () {},
          ),
        );
      }),
      widgets: [
        SliverToBoxAdapter(
          child: Obx(
            () => (controller.isLoadPagination.value)
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(30, (index) => index)
                          .map(
                            (e) => Opacity(
                              opacity: 0.5,
                              child: CardLoading(
                                margin: EdgeInsets.all(10.w),
                                height: 140.h,
                                width: Get.width,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.sp),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                : (controller.paginationData.isEmpty)
                    ? SizedBox(
                        height: Get.height - 150.h,
                        child: Center(
                          child: TextButton(
                            child: Text("لايوجد متاجر اضغط لاعادة التحميل "),
                            onPressed: () =>
                                controller.getPaginationData(isRefresh: true),
                          ),
                        ),
                      )
                    : Column(
                        children: controller.paginationData
                            .map((element) => _buildCard(element))
                            .toList(),
                      ),
          ),
        )
      ],
    );
  }

  Widget _buildCard(StoreModel store) {
    return GestureDetector(
      onTap: ()=>Get.toNamed(AppRoutes.SHOW_STORE_SCREEN,arguments: {"store":store}),
      child: SizedBox(
        width: Get.width,
        height: 140.h,
        child: Card(
          elevation: 5,
          shadowColor: AppColors.highlight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
          margin: EdgeInsets.all(5.sp),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5.sp),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.sp),
                  child: Hero(
                    tag: "store_${store.id}",
                    child: ImageCacheComponent(
                      width: 120.w,
                       image: "${store.img}",
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${store.name} ",
                    maxLines: 1,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,fontSize: 15.sp),
                  ),
                  Text(
                    store.address ?? 'لايوجد عنوان ',
                    maxLines: 1,
                    style:   TextStyle(overflow: TextOverflow.ellipsis,color: AppColors.dark.withOpacity(0.7)),
                  ),
                  TextButton(
                    onPressed: () {
                      if (store.whats != null && store.whats!.isNotEmpty) {
                        launchUrl(Uri.parse("https://wa.me/${store.whats}"));
                      }
                    },
                    child: Text(
                      store.whats ?? 'لايوجد رقم ',
                      maxLines: 1,
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
