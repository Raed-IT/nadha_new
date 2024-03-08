import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/CartScreen/CartScreen.dart';
import 'package:delevary/app/Screens/CartScreen/CartScreenBinding.dart';
import 'package:get/get.dart';

class CartPage extends GetPage {
  CartPage()
      : super(
          name: AppRoutes.cartScreen,
          page: () => CartScreen(),
          binding: CartScreenBinding(),
        );
}
