import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/StoreScreen/StoreScreen.dart';
import 'package:delevary/app/Screens/Store/StoreScreen/StoreScreenBinding.dart';
import 'package:get/get.dart';

class StorePage extends GetPage {
  StorePage()
      : super(
            name: AppRoutes.store,
            page: () => StoreScreen(),
            binding: StoreScreenBinding());
}
