import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/StoresScreens/StoresScreen/StoresScreen.dart';
import 'package:delevary/app/Screens/StoresScreens/StoresScreen/StoresScreenBinding.dart';
import 'package:get/get.dart';

class StoresPage extends GetPage {
  StoresPage()
      : super(
          name: AppRoutes.stores,
          page: () => StoresScreen(),
          binding: StoresScreenBinding(),
        );
}
