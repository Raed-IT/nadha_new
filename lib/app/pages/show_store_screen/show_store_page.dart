import 'package:get/get.dart';
import 'package:nadha/app/pages/show_store_screen/show_store_binding.dart';
import 'package:nadha/app/pages/show_store_screen/show_store_screen.dart';
import 'package:nadha/app/route/routs.dart';

class ShowStorePage extends GetPage {
  ShowStorePage()
      : super(
          page: () => ShowStoreScreen(),
          name: AppRoutes.SHOW_STORE_SCREEN,
          binding: ShowStoreScreenBinding(),
        );
}
