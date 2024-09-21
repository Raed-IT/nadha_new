 import 'package:delevary/app/Screens/HomeScreen/HomeScreen.dart';
import 'package:delevary/app/Screens/HomeScreen/HomeScreenBinding.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:get/get.dart';

import '../../Middlewares/isLogin.dart';

class HomePage extends GetPage {
  HomePage()
      : super(
          name: AppRoutes.homeScreen,
          page: () => HomeScreen(),
          binding: HomeScreenBinding(),
          middlewares: [ IsLoginMiddleware()],
        );
}
