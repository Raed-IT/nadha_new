import 'package:get/get.dart';
import 'package:nadha/app/pages/order_details_screen/order_details_binding.dart';
import 'package:nadha/app/route/routs.dart';

import 'order_details_screen.dart';

class OrderDetailsPage extends GetPage{
  OrderDetailsPage():super(
    name: AppRoutes.ORDER_DETAILS,
    page: ()=>OrderDetailsScreen(),
    binding: OrderDetailsScreenBinding(),
  );
}