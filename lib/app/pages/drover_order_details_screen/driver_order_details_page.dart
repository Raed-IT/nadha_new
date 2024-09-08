import 'package:get/get.dart';
import 'package:nadha/app/pages/drover_order_details_screen/droiver_order_details_binding.dart';
import 'package:nadha/app/route/routs.dart';

import 'driver_order_details_screen.dart';

class DriverOrderDetailsPage extends GetPage {
  DriverOrderDetailsPage()
      : super(
          name: AppRoutes.DRIVER_ORDER_DETAILS,
          page: () => DriverOrderDetailsScreen(),
          binding: DriverOrderDetailsScreenBinding(),
        );
}
