import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/CategoryProductsScreen/CategoryProductsScreen.dart';
import 'package:delevary/app/Screens/CategoryProductsScreen/CategoryProductsScreenBinding.dart';
import 'package:get/get.dart';

class CategoryProductsPage extends GetPage{
  CategoryProductsPage():super(
    name: AppRoutes.categoryProducts,
    page: ()=>CategoryProductsScreen(),
    binding: CategoryProductsScreenBinding()
  );
}