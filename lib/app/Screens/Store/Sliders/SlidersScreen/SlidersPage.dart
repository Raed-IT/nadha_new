import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Sliders/SlidersScreen/SlidersScreen.dart';
import 'package:delevary/app/Screens/Store/Sliders/SlidersScreen/SlidersScreenBinding.dart';
import 'package:get/get.dart';

class SlidersStorePage extends GetPage {
  SlidersStorePage()
      : super(
            name: AppRoutes.storeSliders,
            page: () => SlidersStoreScreen(),
            binding: SlidersStoreScreenBinding());
}
