import 'package:get/get.dart';
import 'package:nadha/app/pages/vendor_store_screen/store_binding.dart';
import 'package:nadha/app/pages/vendor_store_screen/store_screen.dart';
import 'package:nadha/app/route/routs.dart';

class StorePage extends GetPage {
  StorePage()
      : super(
          name: AppRoutes.VENDOR_STORE_SCREEN,
          page: () => StoreScreen(),
          binding: StoreScreenBinding(),
        );
}
