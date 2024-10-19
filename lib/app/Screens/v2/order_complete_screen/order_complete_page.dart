
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/v2/order_complete_screen/order_complete_screen.dart';
import 'package:delevary/app/Screens/v2/order_complete_screen/order_complete_screen_binding.dart';
import 'package:get/get.dart';

class OrderCompletePage extends GetPage{
  OrderCompletePage():super(
    name: AppRoutes.orderComplete,
    page: ()=>OrderCompleteScreen(),
    binding: OrderCompleteScreenBinding()
  );
}