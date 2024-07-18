import 'package:delevary/app/Components/DrawerComponents/DrawerComponent.dart';
import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
import 'package:delevary/app/Screens/Store/BalancesScreen/BalancesScreenController.dart';
import 'package:delevary/app/Screens/Store/BalancesScreen/Components/TransformsListComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../Components/AppBarComponents/AppBarComponent.dart';

class BalancesScreen extends GetView<BalancesScreenController> {
  const BalancesScreen({super.key});

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
                title: "الرصيد",
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
                    TransformsListComponent(),
                    LoadMoreComponent(
                      isFinished: controller.isFinish,
                      isLoad: controller.isLoadMore,
                    )
                  ],
                ).refreshAbel(onRefresh: () async {
                  return await controller.getPaginationData(
                      isRefresh: true);
                }).loadMoreAble(
                  scrollController: scrollController,
                  onLoadMore: () async {
                    return await controller.getPaginationData(
                        isRefresh: false);
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
