import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Products/ProductsScreen.dart';
import 'package:delevary/app/Screens/Store/Products/ProductsScreenBinding.dart';
import 'package:get/get.dart';

class StoreProductsPage extends GetPage {
  StoreProductsPage()
      : super(
            name: AppRoutes.showStore,
            page: () => StoreProductsScreen(),
            binding: StoreProductsScreenBinding());
}
