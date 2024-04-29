import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/Products/UpdateProductScreen/UpdateProductScreen.dart';
import 'package:delevary/app/Screens/Store/Products/UpdateProductScreen/UpdateProductScreenBinding.dart';
import 'package:get/get.dart';

class UpdateProductPage extends GetPage {
  UpdateProductPage()
      : super(
            name: AppRoutes.updateProduct,
            page: () => UpdateProductScreen(),
            binding: UpdateProductScreenBinding());
}
