import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/address_screen/address_binding.dart';
import 'package:nadha/app/pages/address_screen/address_screen.dart';
import 'package:nadha/app/route/routs.dart';

class AddressPage extends GetPage {
  AddressPage()
      : super(
          name: AppRoutes.ADDRESS_SCREEN,
          transition: Transition.rightToLeftWithFade,
          page: () => AddressScreen(),
          binding: AddressScreenBinding(),
        );
}
