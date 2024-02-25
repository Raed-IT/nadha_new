import 'package:delevary/app/Screens/AuthScreens/MainAuthScreen/MainAuthPage.dart';
import 'package:get/get.dart';

import '../Screens/SplashScreen/SplashPage.dart';

class GetPagesProvider {
  static List<GetPage> getPages = [
    SplashPage(),
    MainAuthPage(),
  ];
}
