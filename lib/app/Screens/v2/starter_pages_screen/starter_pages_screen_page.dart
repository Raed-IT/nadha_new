import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/v2/starter_pages_screen/starter_pages_screen.dart';
import 'package:delevary/app/Screens/v2/starter_pages_screen/starter_pages_screen_binding.dart';
import 'package:get/get.dart';

class StarterPage extends GetPage{
  StarterPage():super(
    name: AppRoutes.starterPages,
    page: ()=>StarterPageScreen(),
    binding: StarterPageScreenBinding(),
  );
}