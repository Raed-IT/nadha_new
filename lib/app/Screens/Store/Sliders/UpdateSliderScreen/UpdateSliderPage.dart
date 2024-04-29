import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Sliders/UpdateSliderScreen/UpdateSliderScreen.dart';
import 'package:delevary/app/Screens/Store/Sliders/UpdateSliderScreen/UpdateSliderScreenBindnig.dart';
import 'package:get/get.dart';

class UpdateSliderPage extends GetPage {
  UpdateSliderPage()
      : super(
          name: AppRoutes.addSlider,
          page: () => const UpdateSliderScreen(),
          binding: UpdateSliderScreenBinding(),
        );
}
