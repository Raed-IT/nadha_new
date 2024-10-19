import 'package:delevary/app/Screens/AuthScreens/LoginScreen/LoginPage.dart';
import 'package:delevary/app/Screens/AuthScreens/MainAuthScreen/MainAuthPage.dart';
import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/RegisterPage.dart';
import 'package:delevary/app/Screens/CartScreen/CartPage.dart';
import 'package:delevary/app/Screens/FavoriteScreen/FavoritePage.dart';
import 'package:delevary/app/Screens/HomeScreen/HomePage.dart';
import 'package:delevary/app/Screens/LunchUrlScreen/LunchUrlPage.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldPage.dart';
import 'package:delevary/app/Screens/ProfileScreen/ProfilePage.dart';
import 'package:delevary/app/Screens/SaleScreen/SalePage.dart';
import 'package:delevary/app/Screens/SettingScreen/SettingPage.dart';
import 'package:delevary/app/Screens/Store/BalancesScreen/BalancesPage.dart';
import 'package:delevary/app/Screens/Store/Products/AddProductScreen/AddProductPage.dart';
import 'package:delevary/app/Screens/Store/Products/UpdateProductScreen/UpdateProductPage.dart';
import 'package:delevary/app/Screens/Store/Sliders/AddSliderScreen/AddSliderPage.dart';
import 'package:delevary/app/Screens/Store/StoreScreen/StorePage.dart';
import 'package:delevary/app/Screens/StoresScreens/ShowStoreScreen/ShowStorePage.dart';
import 'package:delevary/app/Screens/v2/categories_screen/categories_screen_page.dart';
import 'package:delevary/app/Screens/v2/checkout_screen/checkout_screen_page.dart';
import 'package:delevary/app/Screens/v2/order_complete_screen/order_complete_page.dart';
import 'package:delevary/app/Screens/v2/starter_pages_screen/starter_pages_screen_page.dart';
import 'package:get/get.dart';

import '../Screens/AddressesScreens/AddAddressScreen/AddAddressPage.dart';
import '../Screens/AddressesScreens/AddressesScreen/AddressesPage.dart';

import '../Screens/CategoryProductsScreen/CategoryProductsPage.dart';
import '../Screens/Delivery/DeliveryOrdersScreen/DeliveryOrdersPage.dart';
import '../Screens/Delivery/MapScreen/MapPage.dart';
import '../Screens/NotificationScreen/NotificationPage.dart';
import '../Screens/OrdersSecreens/OrdersSecreen/OrdersPage.dart';
import '../Screens/SearchScreen/SearchScreenPage.dart';
import '../Screens/ShowProductScreen/ShowProductPage.dart';
import '../Screens/SplashScreen/SplashPage.dart';
import '../Screens/Store/Orders/OrderStorePage.dart';
import '../Screens/Store/Products/ProductsScreen/ProductsPage.dart';
import '../Screens/Store/Sliders/SlidersScreen/SlidersPage.dart';
import '../Screens/StoresScreens/StoresScreen/StoresPage.dart';

class GetPagesProvider {
  static List<GetPage> getPages = [
    SplashPage(),
    MainAuthPage(),
    LoginPage(),
    RegisterPage(),
    HomePage(),
    ProfilePage(),
    SettingPage(),
    CategoryProductsPage(),
    SearchPage(),
    ShowProductPage(),
    AddressesPage(),
    MainScaffoldPage(),
    CartPage(),
    AddAddressPage(),
    FavoritePage(),
    SalePage(),
    NotificationPage(),
    OrdersPage(),
    StoresPage(),
    ShowStorePage(),
    DeliveryOrdersPage(),
    MapPage(),
    StorePage(),
    StoreProductsPage(),
    SlidersStorePage(),
    OrderStorePage(),
    AddProductPage(),
    UpdateProductPage(),
    AddSliderPage(),
    BalancesPage(),
    LunchUrlPage(),
    //   v2
    StarterPage(),
    CategoriesPage(),
    CheckoutPage(),
    OrderCompletePage()
  ];
}
