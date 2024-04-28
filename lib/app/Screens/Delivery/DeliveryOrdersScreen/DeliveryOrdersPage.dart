import 'package:delevary/app/Route/Routs.dart';
 import 'package:get/get.dart';

import 'DeliveryOrdersScreen.dart';
import 'DeliveryOrdersScreenBinding.dart';

class DeliveryOrdersPage extends GetPage {
  DeliveryOrdersPage()
      : super(
          name: AppRoutes.deliveryOrders,
          page: () => DeliveryOrdersScreen(),
          binding: DeliveryOrdersScreenBinding(),
        );
}
