import 'package:delevary/app/Route/Routs.dart';
 import 'package:get/get.dart';

import 'ProductsScreen.dart';
import 'ProductsScreenBinding.dart';

class StoreProductsPage extends GetPage {
  StoreProductsPage()
      : super(
            name: AppRoutes.storeProducts,
            page: () => StoreProductsScreen(),
            binding: StoreProductsScreenBinding());
}
