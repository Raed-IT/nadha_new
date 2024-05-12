import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Orders/OrderStoreScreen.dart';
import 'package:delevary/app/Screens/Store/Orders/OrderStoreScreenBinding.dart';
import 'package:get/get.dart';

class OrderStorePage extends GetPage {
  OrderStorePage()
      : super(
          name: AppRoutes.storeOrders,
          page: () => OrderStoreScreen(),
          binding: OrderStoreScreenBinding(),
        );
}
