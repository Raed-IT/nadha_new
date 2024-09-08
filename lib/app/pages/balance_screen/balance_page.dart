import 'package:get/get.dart';
import 'package:nadha/app/pages/balance_screen/balance_binding.dart';
import 'package:nadha/app/route/routs.dart';

import 'balance_screen.dart';

class BalancePage extends GetPage {
  BalancePage()
      : super(
          name: AppRoutes.BALANCE_SCREEN,
          page: () => BalanceScreen(),
          binding: BalanceScreenBinding(),
        );
}
