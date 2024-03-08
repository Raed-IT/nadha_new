import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/AddressesScreens/AddressesScreen/AddressesScreen.dart';
import 'package:delevary/app/Screens/AddressesScreens/AddressesScreen/AddressesScreenBinding.dart';
import 'package:get/get.dart';

class AddressesPage extends GetPage {
  AddressesPage()
      : super(
          name: AppRoutes.addresses,
          page: () => AddressesScreen(),
          binding: AddressesScreenBinding(),
        );
}
