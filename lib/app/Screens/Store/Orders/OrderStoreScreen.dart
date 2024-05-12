import 'package:delevary/app/Components/LoadMore.dart';
import 'package:delevary/app/Extiontions/loadMoreExtention.dart';
import 'package:delevary/app/Extiontions/refreshExtention.dart';
  import 'package:delevary/app/Screens/Store/Orders/OrderStoreScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../Components/AppBarComponents/AppBarComponent.dart';
import '../../../Components/DrawerComponents/DrawerComponent.dart';
import 'Components/OrdersStoreList.dart';

class OrderStoreScreen extends GetView<OrderStoreScreenController> {
  const OrderStoreScreen({super.key});

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
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.1,
                    repeat: ImageRepeat.repeat,
                    image: AssetImage('assets/images/bg.png'),
                  ),
                ),
              ).animate().blur(
                delay: const Duration(milliseconds: 100),
                begin: const Offset(20, 20),
                duration: const Duration(seconds: 1),
              ),
              Column(
                children: [
                  AppBarComponent(
                    title: "طلبات متجري",
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
                        OrdersStoreListComponent(),
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
            ],
          ),
        ),
      ),
    );
  }
}
