import 'package:get/get.dart';
import 'package:nadha/app/pages/splash_screen/splash_page.dart';
import 'package:nadha/app/pages/vendor_store_screen/store_page.dart';

import '../pages/address_screen/address_page.dart';
import '../pages/auth_screen/auth_page.dart';
import '../pages/balance_screen/balance_page.dart';
import '../pages/cart_screen/cart_page.dart';
import '../pages/drover_order_details_screen/driver_order_details_page.dart';
import '../pages/home_screen/home_page.dart';
import '../pages/notifications_screen/notifications_page.dart';
import '../pages/offer_screen/offer_page.dart';
import '../pages/order_details_screen/order_details_page.dart';
import '../pages/orders_screen/orders_page.dart';
import '../pages/product_details_screen/product_details_page.dart';
import '../pages/profile_screen/profile_page.dart';
import '../pages/show_store_screen/show_store_page.dart';
import '../pages/stores_screen/stores_page.dart';

class GetPagesProvider {
  static List<GetPage> getPages = [
    SplashPage(),
    HomePage(),
    ProductDetailsPage(),
    CartPage(),
    OrdersPage(),
    AuthPage(),
    ProfilePage(),
    OrderDetailsPage(),
    BalancePage(),
    AddressPage(),
    DriverOrderDetailsPage(),
    NotificationsPage(),
    ShowStorePage(),
    OfferPage(),
    StoresPage(),
    StorePage(),
  ];
}
