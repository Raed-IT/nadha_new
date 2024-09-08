import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/pages/components/appbar.dart';
import 'package:nadha/app/pages/home_screen/components/slider_component.dart';
import 'package:nadha/app/pages/home_screen/home_controller.dart';
import 'package:nadha/app/them/app_colors.dart';
import '../../route/routs.dart';
import '../components/bottom_nav_component.dart';
import '../components/products_list_component.dart';
import 'components/categories_component.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.buildScreen(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: (Get.find<MainController>().isAdmin)
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.warning,
              onPressed: () => Get.toNamed(AppRoutes.ORDERS_SCREEN,
                  arguments: <String, bool>{"isAdmin": true}),
              label: Text(
                "جميع الطلبات",
                style: TextStyle(fontSize: 15.sp),
              ))
          : (Get.find<MainController>().user.value?.level == "driver")
              ? FloatingActionButton.extended(
                  backgroundColor: AppColors.warning,
                  onPressed: () => Get.toNamed(AppRoutes.DRIVER_ORDER_DETAILS),
                  label: Text(
                    "طلبات التوصيل",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                )
              : (Get.find<MainController>().isStore)
                  ? FloatingActionButton.extended(
                      backgroundColor: AppColors.warning,
                      onPressed: () => Get.toNamed(AppRoutes.ORDERS_SCREEN,
                          arguments: <String, bool>{"isStore": true}),
                      label: Text(
                        "الطلبات الواردة",
                        style: TextStyle(fontSize: 15.sp),
                      ))
                  : Container(),
      isClosable: true,
      extendBody: true,
      bottomNavigationBar: BottomNavComponent(),
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
        SliderHomeScreenComponent(),
        const SliverPinnedToBoxAdapter(
          child: CategoriesHomeScreenComponents(),
        ),
        SliverToBoxAdapter(
          child: ProductsListComponent(
            products: controller.paginationData,
            isLoad: controller.isLoadPagination,
          ),
        ),
      ],
    );
  }
}
