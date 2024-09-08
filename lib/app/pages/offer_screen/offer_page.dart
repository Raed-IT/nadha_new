import 'package:get/get.dart';
import 'package:nadha/app/pages/offer_screen/offer_binding.dart';
import 'package:nadha/app/pages/offer_screen/offer_screen.dart';
import 'package:nadha/app/route/routs.dart';

class OfferPage extends GetPage {
  OfferPage()
      : super(
          name: AppRoutes.OFFER_SCREEN,
          page: () => OfferScreen(),
          binding: OfferScreenBinding(),
        );
}
