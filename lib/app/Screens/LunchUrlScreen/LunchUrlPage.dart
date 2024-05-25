import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/LunchUrlScreen/LunchUrlScreen.dart';
import 'package:delevary/app/Screens/LunchUrlScreen/LunchUrlScreenBinding.dart';
import 'package:get/get.dart';

class LunchUrlPage extends GetPage {
  LunchUrlPage()
      : super(
          name: AppRoutes.lunchUrl,
          binding: LunchUrlScreenBinding(),
          page: () => LunchUrlScreen(),
        );
}
