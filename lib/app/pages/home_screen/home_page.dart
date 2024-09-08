import 'package:get/get.dart';
import 'package:nadha/app/pages/home_screen/home_binding.dart';
import 'package:nadha/app/route/routs.dart';

import '../../data/middelwares/is_login.dart';
import 'home_screen.dart';

class HomePage extends GetPage {
  HomePage()
      : super(
            name: AppRoutes.HOME_SCREEN,
            page: () => HomeScreen(),
            binding: HomeScreenBinding(),
            middlewares: [IsLoginMiddleware()]
  );
}
