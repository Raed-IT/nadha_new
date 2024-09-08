import 'package:get/get.dart';
import 'package:nadha/app/pages/stores_screen/stores_binding.dart';
import 'package:nadha/app/pages/stores_screen/stores_screen.dart';
import 'package:nadha/app/route/routs.dart';

class StoresPage extends GetPage{
  StoresPage():super(
    name: AppRoutes.STORE_SCREEN,
    page: ()=>StoresScreen(),
    binding: StoresScreenBinding(),
  );
}