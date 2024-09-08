import 'package:get/get.dart';
import 'package:nadha/app/pages/orders_screen/orders_binding.dart';
import 'package:nadha/app/route/routs.dart';

import 'orders_screen.dart';

class OrdersPage extends GetPage{
  OrdersPage():super(
    name: AppRoutes.ORDERS_SCREEN,
    page: ()=>OrdersScreen(),
    binding: OrdersScreenBinding(),
  );
}