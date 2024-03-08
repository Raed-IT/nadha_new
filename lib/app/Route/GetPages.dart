import 'package:delevary/app/Screens/AuthScreens/LoginScreen/LoginPage.dart';
import 'package:delevary/app/Screens/AuthScreens/MainAuthScreen/MainAuthPage.dart';
import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/RegisterPage.dart';
import 'package:delevary/app/Screens/HomeScreen/HomePage.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldPage.dart';
import 'package:delevary/app/Screens/ProfileScreen/ProfilePage.dart';
import 'package:delevary/app/Screens/SettingScreen/SettingPage.dart';
import 'package:get/get.dart';

import '../Screens/AddressesScreens/AddressesScreen/AddressesPage.dart';
import '../Screens/CategoriesScreen/CategoriesPage.dart';
import '../Screens/CategoryProductsScreen/CategoryProductsPage.dart';
import '../Screens/SearchScreen/SearchScreenPage.dart';
import '../Screens/ShowProductScreen/ShowProductPage.dart';
import '../Screens/SplashScreen/SplashPage.dart';

class GetPagesProvider {
  static List<GetPage> getPages = [
    SplashPage(),
    MainAuthPage(),
    LoginPage(),
    RegisterPage(),
    HomePage(),
    ProfilePage(),
    SettingPage(),
    CategoriesPage(),
    CategoryProductsPage(),
    SearchPage(),
    ShowProductPage(),
    AddressesPage(),
    MainScaffoldPage()
  ];
}
