import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/StoresScreens/ShowStoreScreen/ShowStoreScreen.dart';
import 'package:delevary/app/Screens/StoresScreens/ShowStoreScreen/ShowStoreScreenBinding.dart';
import 'package:get/get.dart';

class ShowStorePage extends GetPage {
  ShowStorePage()
      : super(
          name: AppRoutes.showStore,
          page: () => ShowStoreScreen(),
          binding: ShowStoreScreenBinding(),
        );
}
