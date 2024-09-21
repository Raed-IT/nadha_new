import 'package:delevary/app/Screens/AuthScreens/MainAuthScreen/MainAuthBindnig.dart';
import 'package:delevary/app/Screens/AuthScreens/MainAuthScreen/MainAuthScreen.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:get/get.dart';

class MainAuthPage extends GetPage {
  MainAuthPage()
      : super(
          name: AppRoutes.mainAuthScreen,
          page: () => MainAuthScreen(),
          binding: MainAuthScreenBinding(),
        );
}
