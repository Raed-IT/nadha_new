import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/SaleScreen/SaleScreen.dart';
import 'package:delevary/app/Screens/SaleScreen/SaleScreenBindnig.dart';
import 'package:get/get.dart';

class SalePage extends GetPage {
  SalePage()
      : super(
          name: AppRoutes.sale,
          page: () => SaleScreen(),
          binding: SaleScreenBinding(),
        );
}
