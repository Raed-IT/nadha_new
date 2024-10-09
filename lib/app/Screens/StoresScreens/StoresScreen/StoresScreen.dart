import 'package:delevary/app/Components/AppBarComponents/v2/appBar/AppBarComponent.dart';
import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Components/v2/search_filed_component.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Components/StoresList.dart';
import 'package:delevary/app/Screens/StoresScreens/StoresScreen/StoresScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Components/DrawerComponents/DrawerComponent.dart';

class StoresScreen extends GetView<StoresScreenController> {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerComponent(),
      body: Builder(
        builder: (context) => Container(
          height: Get.height,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              AppBarComponent(
                openDrawer: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(0),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Center(
                      child: Text(
                        "المتاجر",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.sp),
                      ),
                    ),
                    Obx(() {
                      return SearchFiledComponent(
                        onChanged: controller.search,
                        isLoad: RxBool(
                            controller.isLoadPaginationData.value &&
                                controller.paginationData.isEmpty),
                        onEditingComplete: () {
                          controller.getPaginationData(isRefresh: true);
                        },
                      );
                    }),
                    StoresListComponent(
                      getFreshData: () {
                        controller.getFreshData();
                      },
                      stores: controller.paginationData,
                      isLoad: controller.isLoadPaginationData,
                    ),
                    LoadMoreComponent(
                      isFinished: controller.isFinish,
                      isLoad: controller.isLoadMore,
                    )
                  ],
                )
                    .loadMoreAble(
                  scrollController: scrollController,
                  onLoadMore: () async {
                    await controller.loadMore();
                  },
                )
                    .refreshAbel(
                  onRefresh: () async {
                    await controller.getFreshData();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
