import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/offer_screen/offer_controller.dart';
import '../components/appbar.dart';
import '../components/bottom_nav_component.dart';
import '../components/products_list_component.dart';

class OfferScreen extends GetView<OfferScreenController> {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return controller.buildScreen(
      extendBody: true,
      bottomNavigationBar:   BottomNavComponent(),
      appBar: Builder(builder: (context) {
        return SliverPinnedToBoxAdapter(
          child: AppBarComponent(
            hintText: "ابحث في العروض ....",
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
          child: ProductsListComponent(
            isOffer: true,
            products: controller.paginationData,
            isLoad: controller.isLoadPagination,
          ),
        ),
      ],
    );
  }
}
