import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:get/get.dart';

class CategoriesScreenController extends GetxController {
  final List<CategoryModel> categories = Get.arguments?['categories']??[];

}
