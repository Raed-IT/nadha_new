import 'package:delevary/app/Middlewares/isLogin.dart';
import 'package:delevary/app/Middlewares/is_read_starter_pages.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreen.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenBinding.dart';
import 'package:get/get.dart';

class MainScaffoldPage extends GetPage {
  MainScaffoldPage()
      : super(
          name: AppRoutes.mainScaffoldScreen,
          page: () => MainScaffoldScreen(),
          binding: MainScaffoldScreenBinding(),
          middlewares: [
            // IsReadStarterPagesMiddleware(),
            // IsLoginMiddleware(),
          ],
        );
}
