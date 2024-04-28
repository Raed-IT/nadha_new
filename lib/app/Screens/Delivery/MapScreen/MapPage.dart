import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Delivery/MapScreen/MapScreen.dart';
import 'package:delevary/app/Screens/Delivery/MapScreen/MapScreenBinding.dart';
import 'package:get/get.dart';

class MapPage extends GetPage{
  MapPage():super(
    name: AppRoutes.map,
    page: ()=>MapScreen(),
    binding: MapScreenBinding(),
  );
}