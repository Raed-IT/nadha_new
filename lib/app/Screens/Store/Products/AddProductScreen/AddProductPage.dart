import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Products/AddProductScreen/AddProductScreen.dart';
import 'package:delevary/app/Screens/Store/Products/AddProductScreen/AddProductScreenBinding.dart';
import 'package:get/get.dart';

class AddProductPage extends GetPage {
  AddProductPage()
      : super(
          page: () => AddProductScreen(),
          name: AppRoutes.addProduct,
          binding: AddProductScreenBinding(),
        );
}
