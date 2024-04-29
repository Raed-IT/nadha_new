import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Sliders/AddSliderScreen/AddSliderScreen.dart';
import 'package:delevary/app/Screens/Store/Sliders/AddSliderScreen/AddSliderScreenBinding.dart';
import 'package:get/get.dart';

class AddSliderPage extends GetPage {
  AddSliderPage()
      : super(
          name: AppRoutes.addSlider,
          page: () => AddSliderScreen(),
          binding: AddSliderScreenBinding(),
        );
}
