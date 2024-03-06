import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreen.dart';
import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenBinding.dart';
import 'package:get/get.dart';

class ShowProductPage extends GetPage {
  ShowProductPage()
      : super(
          name: AppRoutes.showProduct,
          page: () => ShowProductScreen(),
          binding: ShowProductScreenBinding(),
        );
}
