import 'package:delevary/app/Screens/SplashScreen/SplashBinding.dart';
import 'package:delevary/app/Screens/SplashScreen/SplashScreen.dart';
import 'package:delevary/app/route/Routs.dart';
import 'package:get/get.dart';

class SplashPage extends GetPage {
  SplashPage()
      : super(
          name: AppRoutes.splashScreen,
          page: () => SplashScreen(),
          binding: SplashScreenBinding(),
        );
}
