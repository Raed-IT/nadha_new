import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/BalancesScreen/BalancesScreen.dart';
import 'package:delevary/app/Screens/Store/BalancesScreen/BalancesScreenBinding.dart';
import 'package:get/get.dart';

class BalancesPage extends GetPage {
  BalancesPage()
      : super(
            name: AppRoutes.balances,
            page: () => BalancesScreen(),
            binding: BalancesScreenBinding());
}
