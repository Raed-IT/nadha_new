import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/OrdersSecreens/OrdersSecreen/OrdersSecreen.dart';
import 'package:delevary/app/Screens/OrdersSecreens/OrdersSecreen/OrdersSecreenBinding.dart';
import 'package:get/get.dart';

class OrdersPage extends GetPage {
  OrdersPage()
      : super(
          name: AppRoutes.orders,
          page: () => OrdersScreen(),
          binding: OrdersSecreenBinding(),
        );
}
