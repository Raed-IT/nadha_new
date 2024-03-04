import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/CategoriesScreen/CategoriesScreen.dart';
import 'package:delevary/app/Screens/CategoriesScreen/CategoriesScreenBinding.dart';
import 'package:get/get.dart';

class CategoriesPage extends GetPage {
  CategoriesPage()
      : super(
          name: AppRoutes.categories,
          page: () => const CategoriesScreen(),
          binding: CategoriesScreenBinding(),
        );
}
