import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Categories/CategoriesScreen/CategoriesScreen.dart';
import 'package:delevary/app/Screens/Store/Categories/CategoriesScreen/CategoriesScreenBinding.dart';
import 'package:get/get.dart';

class CategoriesStorePage extends GetPage {
  CategoriesStorePage()
      : super(
          name: AppRoutes.storeCategories,
          page: () => CategoriesStoreScreen(),
          binding: CategoriesStoreScreenBinding(),
        );
}
