import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Sliders/SlidersScreen/Componsnts/SlidersListComponent.dart';
import 'package:delevary/app/Screens/Store/Sliders/SlidersScreen/SlidersScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../Components/AppBarComponents/AppBarComponent.dart';
import '../../../../Components/DrawerComponents/DrawerComponent.dart';

class SlidersStoreScreen extends GetView<SlidersStoreScreenController> {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic product = await Get.toNamed(AppRoutes.addSlider);
          if (product != null) {
            controller.paginationData.insert(0, product);
          }
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          FontAwesomeIcons.plus,
          size: 20.sp,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerComponent(),
      body: Builder(
        builder: (context) => Container(
          height: Get.height,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              AppBarComponent(
                title: "إعلانات متجري",
                openDrawer: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(0),
                  physics: const BouncingScrollPhysics(),
                  children: [StoreSliderListComponent()],
                ).refreshAbel(onRefresh: () async {
                  await controller.getDataFromApi();
                }).loadMoreAble(
                    scrollController: scrollController,
                    onLoadMore: () async {
                      await controller.loadMore();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
