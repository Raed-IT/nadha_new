import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/v2/checkout_screen/checkout_screen.dart';
import 'package:delevary/app/Screens/v2/checkout_screen/checkout_screen_binding.dart';
import 'package:get/get.dart';

class CheckoutPage extends GetPage {
  CheckoutPage()
      : super(
            name: AppRoutes.checkoutPage,
            page: () => CheckoutScreen(),
            binding: CheckoutScreenBinding());
}
