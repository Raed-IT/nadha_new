 import 'package:get/get.dart';
import 'package:nadha/app/pages/splash_screen/splash_binding.dart';
import 'package:nadha/app/pages/splash_screen/splash_screen.dart';

import '../../route/routs.dart';

class SplashPage extends GetPage {
  SplashPage()
      : super(
          name: AppRoutes.SPLASH_SCREEN,
          page: () => SplashScreen(),
          binding: SplashBinding(),
        );
}
