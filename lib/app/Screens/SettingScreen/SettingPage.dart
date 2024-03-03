import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/SettingScreen/SettingScreen.dart';
import 'package:delevary/app/Screens/SettingScreen/SettingScreenBinding.dart';
import 'package:get/get.dart';

class SettingPage extends GetPage {
  SettingPage()
      : super(
          name: AppRoutes.setting,
          page: () => SettingScreen(),
          binding: SettingScreenBinding(),
        );
}
