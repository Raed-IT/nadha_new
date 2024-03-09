import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/AddressesScreens/AddAddressScreen/AddAddressScreen.dart';
import 'package:delevary/app/Screens/AddressesScreens/AddAddressScreen/AddAddressScreenBinding.dart';
import 'package:get/get.dart';

class AddAddressPage extends GetPage {
  AddAddressPage()
      : super(
          name: AppRoutes.addAddress,
          page: () => AddAddressScreen(),
          binding: AddAddressScreenBinding(),
        );
}
