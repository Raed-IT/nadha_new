import 'package:get/get.dart';
import 'package:nadha/app/pages/cart_screen/cart_binding.dart';
import 'package:nadha/app/pages/cart_screen/cart_screen.dart';
import 'package:nadha/app/route/routs.dart';

class CartPage extends GetPage {
  CartPage()
      : super(
          name: AppRoutes.CART_SCREEN,
          page: () => CartScreen(),
          binding: CartScreenBinding(),
        );
}
