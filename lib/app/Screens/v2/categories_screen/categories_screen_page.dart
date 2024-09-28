import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/v2/categories_screen/categories_screen.dart';
import 'package:delevary/app/Screens/v2/categories_screen/categories_screen_binding.dart';
 import 'package:get/get.dart';


class CategoriesPage extends GetPage {
  CategoriesPage()
      : super(
          name: AppRoutes.categoriesV2,
          page: () => CategoriesScreen(),
        binding: CategoriesScreenBinding()
  );
}
